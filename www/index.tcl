ad_page_contract {
    Index for course administration
    @author          Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation date   31-01-2005

} {

}
set page_title "[_ courses.course_catalog]"
set context ""
set return_url "/courses/cc-admin/course-list"
set cc_package_id [apm_package_id_from_key "courses"]

set user_id [auth::get_user_id]
if {[permission::permission_p -party_id $user_id -object_id $cc_package_id -privilege "admin"]} {
    set admin_p 1
} else {
    set admin_p 0
}

if {[permission::permission_p -party_id $user_id -object_id $cc_package_id -privilege "create"]} {
    set create_p 1
} else {
    set create_p 0
}