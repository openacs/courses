ad_page_contract {
    Displays a list of all courses to grant permission

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   28-01-2005
} {

}

set user_id [auth::get_user_id]
set page_title "[_ courses.grant] [_ courses.course_list]"
set context [list $page_title]
set return_url "/courses/cc-admin/grant-list"

set asm_package_id [apm_package_id_from_key assessment]

if { [acs_user::site_wide_admin_p] } {
    set query get_course_info_site_wide
    set site_wide 1
} else {
    set query get_course_info
    set site_wide 0
}


db_multirow -extend { asm_name item_id creation_user } course_list $query {} {
    set asm_name [db_string get_asm_name { } -default "[_ courses.not_associated]"]
    set item_id [course_catalog::get_item_id -name $course_key]
    set creation_user [course_catalog::get_creation_user -object_id $item_id]
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
		@course_list.course_key@
	    }
	}
	name  {
	    label "[_ courses.course_name]"
	    display_template {
		@course_list.course_name@
	    }
	}
	assessment_id  {
	    label "[_ courses.asm]:"
	    display_template {
		@course_list.asm_name@
	    }
	}
	permission {
	    label "[_ courses.grant_per]"
	    display_template {
		<div align=center>
		<if @course_list.creation_user@ eq $user_id>
		    <a href="grant-user-list?object_id=@course_list.item_id@&creation_user=@course_list.creation_user@&course_key=@course_list.course_key@">Grant</a>
		</if>
		<else>
		    <if $site_wide eq 1>
		       <a href="grant-user-list?object_id=@course_list.item_id@&creation_user=@course_list.creation_user@&course_key=@course_list.course_key@" title="\#courses.grant_to_others\#">Grant</a>
		    </if>
		    <else>
		       #courses.not_allowed#
		    </else>
		</else>
		</div>
	    }
	}
    }