ad_page_contract {
    Displays a form to add a course or add a new revision of a course (edit)

    @author          Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation date   27-01-2005

} {
    course_id:optional
    { return_url "" }
}

if { [string equal $return_url ""]} {
    set return_url "/courses/cc-admin"
}

# To disable the element course_key
if { [info exists course_id] } {
    set mode display
} else {
    set mode edit
}

set user_id [auth::get_user_id]
set page_title ""
set context ""

# Check if users has admin permission to edit course_catalog
if { [info exists course_id] } {
    permission::require_permission -party_id $user_id -object_id $course_id -privilege "admin"
}

# Get assessments
set asm_package_id [apm_package_id_from_key assessment]
set asm_list [list [list "[_ courses.not_associate]" "-1"]]
db_foreach  assessment {} {
    lappend asm_list [list $title $assessment_id]
}

# Get a list of all the attributes asociated to course_catalog
set attribute_list [package_object_attribute_list -start_with course_catalog course_catalog]
set elements ""


# Creates the elements to show with ad_form
set i 0
foreach attribute $attribute_list {
    set element "{[lindex $attribute 2]:[lindex $attribute 4](text) {label \"[lindex $attribute 3]\"}}"
    if { [string equal [lindex $attribute 2] "course_key"]} {
	set element "{[lindex $attribute 2]:[lindex $attribute 4](text) {label \"[lindex $attribute 3]\"} {mode $mode}}"
    } else {
	set element "{[lindex $attribute 2]:[lindex $attribute 4](text) {label \"[lindex $attribute 3]\"}}"
    }
    if { [string equal [lindex $attribute 2] "assessment_id"]} {
	set asm_num $i
    }
    if { [string equal [lindex $attribute 2] "course_info"]} {
	set info_num $i
    }
    lappend elements $element
    incr i
}

# Create the form
ad_form -name add_course -export {return_url $return_url} -form {
    course_id:key
}


# Create the element of the form
set i 0
foreach item $elements {
    if {[string equal $i $asm_num]} {
	ad_form -extend -name add_course -form {
	    { assessment_id:text(select)
		{label "[_ courses.asm]"}
		{options $asm_list}
	    }
	}
	incr i
    } else {
	if {[string equal $i $info_num]} {
	    ad_form -extend -name add_course -form {
		{ course_info:text(textarea)
		    {label "[_ courses.course_info]"}
		    {html  {rows 7 cols 35}}
		}
	    }
	} else {
	    ad_form -extend -name add_course -form [lindex $elements $i]
	}
	incr i
    }
}

ad_form -extend -name add_course -new_data {
    # New item and revision in the CR
    set folder_id [course_catalog::get_folder_id]
    set item_id [content::item::new -name $course_key -parent_id $folder_id -content_type "course_catalog"]
    set course_id [content::revision::new -item_id $item_id -title $course_key \
			 -description "$course_name: $course_info"]

    # Fill the table with other info
    db_transaction {
	db_dml update_course_info { }
    }
    # Set the new revision live
    course_catalog::set_live -name $course_key -revision_id $course_id
    # Grant admin privileges to the user over the item in the CR
    permission::grant -party_id $user_id -object_id $course_id  -privilege "admin"

} -edit_data {
    
    # New revision in the CR
    set folder_id [course_catalog::get_folder_id]
    set item_id [course_catalog::get_item_id -name $course_key -parent_id $folder_id -content_type "course_catalog"]
    set course_id [content::revision::new -item_id $item_id -title $course_key \
		       -description "$course_name: $course_info"]
    
    # Fill the table with other info
    db_transaction {
	db_dml update_course_info { }
    }
    # Set the new revision live
    course_catalog::set_live -name $course_key -revision_id $course_id
    # Grant admin privileges to the user over the item in the CR
    permission::grant -party_id $user_id -object_id $course_id  -privilege "admin"

} -new_request {
    set context [list "[_ courses.add_course]"]
    set page_title "[_ courses.add_course]"
    set return_url "$return_url"

} -edit_request {
    set context [list "[_ courses.edit_course]"]
    set page_title "[_ courses.edit_course]"
    set return_url "$return_url"
    db_1row get_course_info { }
    db_string get_course_assessment { } -default "[_ courses.not_associated]"

} -after_submit {
    ad_returnredirect "$return_url"
}









