ad_page_contract {
    Displays a list of all dotlrn classes to associate to a course_catalog(course_id)

    @author          Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation date   31-01-2005
} {
    course_id:notnull
    { course_key ""}
    { return_url "" }
}

set page_title "[_ courses.dotlrn_list]"
if {[string equal $return_url ""]} {
    set return_url "/courses/cc-admin/courses-list"
}
set user_id [auth::get_user_id]

# Check if users has admin permission to edit course_catalog
permission::require_permission -party_id $user_id -object_id $course_id -privilege "admin"

set context [list [list "/courses/cc-admin/course-list"  "[_ courses.course_list]"] "[_ courses.dotlrn_list]"]

set asm_package_id [apm_package_id_from_key assessment]

db_multirow classes_list get_dotlrn_classes {}

template::list::create \
    -name dotlrn_classes \
    -multirow classes_list \
    -key class_id \
    -bulk_action_method post \
    -bulk_action_export_vars {}\
    -row_pretty_plural "[_ courses.dotlrn_classes]" \
    -elements {
	class  {
	    label "[_ courses.class_name]"
	    display_template {
		    <a href="@classes_list.url@">@classes_list.pretty_name@</a>
	    }
	}
	dep_name {
	    label "[_ courses.dep_name]"
	    display_template {
		@classes_list.department_name@
	    }
	}
	term_name  {
	    label "[_ courses.term_name]"
	    display_template {
		    @classes_list.term_name@
	    }
	}
	subject  {
	    label "[_ courses.subject_name]"
	    display_template {
		    @classes_list.class_name@
	    }
	}
	associate {
	    display_template {
		<a href="associate-course?course_id=$course_id&class_id=@classes_list.class_id@&return_url=$return_url" title="\#courses.associate_to_class\#\">#courses.associate#</a>
	    }
	}
    }
