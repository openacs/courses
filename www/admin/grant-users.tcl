ad_page_contract {
    Gives users admin permissions on course_catalog

    @author          Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation date   29-01-2005
} {
    p_user_id:multiple
}

# course_catalog package_id
set cc_package_id [apm_package_id_from_key "courses"]

# Grants Permission for all the users in p_user_id
foreach user $p_user_id {
    permission::grant -party_id $user -object_id $cc_package_id  -privilege "create"
}



ad_returnredirect "/courses/admin/grant-list"
