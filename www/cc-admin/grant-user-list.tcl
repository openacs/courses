ad_page_contract {
    Displays a list of all proffesors from dotlrn

    @author          Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation date   28-01-2005
} {
    { return_url "" }
    { user_name "" }
    { user_email "" }
}

set user_id [auth::get_user_id]
# course_catalog package_id
set cc_package_id [apm_package_id_from_key "courses"]

set page_title "[_ courses.search_u]"
set context [list [list "/courses/cc-admin/grant-list" "[_ courses.grant] [_ courses.course_list]"] "[_ courses.search_u]"]
if {[string equal $return_url ""]} {
    set return_url "/courses/admin/grant-list"
}

if {![string equal $user_name ""]} {
    set query select_users_name
    if {![string equal $user_email ""]} {
	set query select_users_name_email
    }
} else {
    set query select_users
    if {![string equal $user_email ""]} {
	set query select_users_email
    }
}

# To search for users
ad_form -name search_user -form {
    {user_name:text(text),optional
	{label "[_ courses.search_user]"}
	{help_text "[_ courses.search_help]"}
    }
    {user_email:text(text),optional
	{label "[_ courses.search_user_email]"}
    }
}

db_multirow -extend { privilege email } grant_list $query {} {
    set privilege [permission::permission_p -party_id $p_user_id -object_id $cc_package_id -privilege "create"]
    set email [email_image::get_user_email -user_id $p_user_id]
}

template::list::create \
    -name grant_list \
    -multirow grant_list \
    -key p_user_id \
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

