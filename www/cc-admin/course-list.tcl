ad_page_contract {
    Displays a list of all courses

    @author          Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation date   28-01-2005
} {

}

set user_id [auth::get_user_id]
set context [list "[_ courses.course_list]"]
set page_title "[_ courses.course_list]"
set return_url "/courses/cc-admin/course-list"

set asm_package_id [apm_package_id_from_key assessment]

if { [acs_user::site_wide_admin_p] } {
    set query get_course_info_site_wide
} else {
    set query get_course_info
}


db_multirow -extend { asm_name rel } course_list $query {} {
    set asm_name [db_string get_asm_name { } -default "[_ courses.not_associated]"]
    set rel [course_catalog::has_relation -course_id $course_id]
}

template::list::create \
    -name course_list \
    -multirow course_list \
    -key course_id \
    -bulk_action_method post \
    -bulk_action_export_vars {
    }\
    -row_pretty_plural "[_ courses.courses]" \
    -elements {
	key {
	    label "[_ courses.course_key]"
	    display_template {
		<a href=add-edit-course?course_id=@course_list.course_id@&return_url=$return_url \
		    title="[_ courses.new_ver]">\
		    <img border=0 src=/resources/Edit16.gif></a>
		<a href="revision-list?course_key=@course_list.course_key@&return_url=$return_url&course_id=@course_list.course_id@" title="[_ courses.see_all_rev]">@course_list.course_key@</a>
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
	    label "[_ courses.asm]:"
	    display_template {
		@course_list.asm_name@
	    }
	}
	dotlrn {
	    label "[_ courses.dotlrn]"
	    display_template {
		<if @course_list.rel@ eq 0>
		#courses.no# (<a href="dotlrn-list?course_id=@course_list.course_id@&course_key=@course_list.course_key@&return_url=$return_url" title="\#courses.associate_this\#"><i>#courses.associate#</i></a>)
		</if>
		<else>
		#courses.yes# (<a href="watch-association?course_id=@course_list.course_id@&course_key=@course_list.course_key@" title="\#courses.watch_assoc#"><i>#courses.watch#</i></a>)
		</else>
	    }
	}
    }