ad_page_contract {
    Displays a list of all revisions for one course

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   28-01-2005
} {
    { return_url "" }
    course_key:notnull
    course_id:notnull
}

set page_title "[_ courses.rev_list]"
if {[string equal $return_url ""]} {
    set return_url "/courses/course-list"
}

set user_id [auth::get_user_id]

# Check if users has admin permission to edit course_catalog
permission::require_permission -party_id $user_id -object_id $course_id -privilege "admin"


set context [list [list "/courses/cc-admin/course-list"  "[_ courses.course_list]"] "[_ courses.rev_list]"]

set asm_package_id [apm_package_id_from_key assessment]

db_multirow -extend { asm_name class_name delete_p } course_list get_course_info {} {
    set asm_name [db_string get_asm_name { } -default "[_ courses.not_associated]"]
    set class_id [course_catalog::has_relation -course_id $course_id]
    set class_name [db_string get_class_info { } -default "[_ courses.not_associated]"]
    set delete_p [course_catalog::check_live_latest -revision_id $course_id]
}

template::list::create \
    -name course_list \
    -multirow course_list \
    -key course_id \
    -bulk_action_method post \
    -bulk_action_export_vars {
    }\
    -row_pretty_plural "[_ courses.revisions]" \
    -elements {
	key {
	    label "[_ courses.course_key]"
	    display_template {
	      @course_list.course_key@
	    }
	}
	name  {
	    label "[_ courses.course_name]"
	    display_template {
		    @course_list.course_name@
	    }
	}
	info  {
	    label "[_ courses.course_info]"
	    display_template {
		    @course_list.course_info@
	    }
	}
	assessment_id  {
	    label "[_ courses.asm]"
	    display_template {
		    @course_list.asm_name@
	    }
	}
	class_name {
	    label "[_ courses.dotlrn]"
	    display_template {
		@course_list.class_name@
	    }
	}
	live_revision {
	    display_template {
		<if @course_list.course_id@ eq @course_list.live_revision@>
		<img border=0 src="/courses/images/live.gif">   
		</if>
		<else>
		<a href="go-live?course_key=@course_list.course_key@&revision_id=@course_list.course_id@" title="[_ courses.make_live]"><img border=0 src="/courses/images/golive.gif"></a>
		</else>
	    }
	}
    }