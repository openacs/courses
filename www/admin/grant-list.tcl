ad_page_contract {
    Displays a list of all proffesors from dotlrn

    @author          Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation date   28-01-2005
} {
    { return_url "" }
}

set user_id [auth::get_user_id]
# course_catalog package_id
set cc_package_id [apm_package_id_from_key "courses"]

set page_title "[_ courses.grant_list]"
if {[string equal $return_url ""]} {
    set return_url "/courses/admin/grant-list"
}

set context [list $page_title]
db_multirow -extend { privilege email } grant_list select_users {} {
    set privilege [permission::permission_p -party_id $p_user_id -object_id $cc_package_id -privilege "create"]
    set email [email_image::get_user_email -user_id $p_user_id]
}

template::list::create \
    -name grant_list \
    -multirow grant_list \
    -key p_user_id \
    -bulk_actions {"\#courses.grant\#" "grant-users?" "\#courses.grant_per\#"\
		       "\#courses.revoke\#" "revoke-users?" "\#courses.revoke_per\#" }\
    -bulk_action_method post \
    -bulk_action_export_vars {
    }\
    -row_pretty_plural "[_ courses.users_to_grant]" \
    -elements {
	name {
	    label "[_ courses.user_name]"
	    display_template {
		@grant_list.first_names@ @grant_list.last_name@
	    }
	}
	email {
	    label "[_ courses.email]"
	    display_template {
		@grant_list.email;noquote@
	    }
	}
	permission {
	    label "[_ courses.permission]"
	    display_template {
		<if @grant_list.privilege@ eq 1>
		   [_ courses.granted]
		</if>
		<else>
		   <i>[_ courses.not_allowed]</i>
		</else>
	    }
	}
    }

