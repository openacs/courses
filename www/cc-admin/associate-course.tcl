ad_page_contract {
    Associates course_catalog's course_id with dotlrn's class_instance_id

    @author          Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation date   31-01-2005
} {
    course_id:notnull
    class_id:notnull
    { return_url ""}
}

course_catalog::add_relation -course_id $course_id -class_id $class_id

if { [string equal $return_url ""] } {
    ad_returnredirect "/courses/cc-admin/dotlrn-list"
} else {
    ad_returnredirect "$return_url"
}
