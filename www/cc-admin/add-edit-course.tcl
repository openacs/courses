ad_page_contract {
    Displays a form to add a course or add a new revision of a course (edit)

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   27-01-2005

} {
    course_id:optional
    mode:optional
    { return_url "" }
}

if { [string equal $return_url ""]} {
    set return_url "/courses/cc-admin"
}

set page_title ""
set context ""

set user_id [ad_conn user_id]

if { [info exists mode] } {
    # Check if users has admin permission to edit course_catalog
    permission::require_permission -object_id $course_id -privilege "admin"
    # To disable the element course_key
    set mode display
} else {
    set mode edit
}

# Get assessments
set asm_package_id [apm_package_id_from_key assessment]
set asm_list [list [list "[_ courses.not_associate]" "-1"]]
db_foreach assessment { } {
    if { [permission::permission_p -object_id $assessment_id -privilege "admin"] == 1 } {
	lappend asm_list [list $title $assessment_id] 
    }
}

# Get a list of all the attributes asociated to course_catalog
set attribute_list [package_object_attribute_list -start_with course_catalog course_catalog]
set elements ""


# Creates the elements to show with ad_form

foreach attribute $attribute_list {
    set element_mode ""
    set aditional_type ""
    set aditional_elements ""
    switch [lindex $attribute 4] {
	string {
	    if { [string equal [lindex $attribute 2] "assessment_id"]} {
		set aditional_type "(select)"
		set aditional_elements [list options $asm_list]
	    } else {
		if { [string equal [lindex $attribute 2] "course_key"]} {
		    set element_mode [list mode $mode]
		} 
	    }
	}
	text {
	    set aditional_type "(textarea)"
	    set aditional_elements "{html  {rows 7 cols 35}}"
	}
	integer {
	    if { [string equal [lindex $attribute 2] "assessment_id"]} {
		set aditional_type "(select)"
		set aditional_elements [list options $asm_list]
	    }
	}
    }
    set element [list [lindex $attribute 2]:text${aditional_type} [list label [lindex $attribute 3]] $aditional_elements $element_mode]

    lappend elements $element

}


# Create the form
ad_form -name add_course -export {return_url $return_url} -form {
    course_id:key
}


ad_form -extend -name add_course -form $elements

ad_form -extend -name add_course -new_data {
    # New item and revision in the CR
    set folder_id [course_catalog::get_folder_id]
    set attribute_list [package_object_attribute_list -start_with course_catalog course_catalog]
    set form_attributes [list]
    foreach attribute $attribute_list {
	set attr_name [lindex $attribute 2]
	lappend form_attributes [list $attr_name [set $attr_name]]
    }

    set item_id [content::item::new -name $course_key -parent_id $folder_id \
		     -content_type "course_catalog" -creation_user $user_id \
		     -attributes $form_attributes]

    # Grant admin privileges to the user over the item in the CR
    permission::grant -party_id $user_id -object_id $item_id  -privilege "admin"

} -edit_data {
    
    # New revision in the CR
    set folder_id [course_catalog::get_folder_id]
    set item_id [course_catalog::get_item_id -name $course_key -parent_id $folder_id]
    set attribute_list [package_object_attribute_list -start_with course_catalog course_catalog]
    set form_attributes [list]
    foreach attribute $attribute_list {
	set attr_name [lindex $attribute 2]
	lappend form_attributes [list $attr_name [set $attr_name]]
    }
    set course_id [content::revision::new -item_id $item_id \
		       -attributes $form_attributes -is_live t]

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









