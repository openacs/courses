ad_page_contract {
    Associates course_catalog's course_id with dotlrn's class_instance_id

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   31-01-2005
} {
    course_id:notnull
    object_id:multiple
    { return_url ""}
}

foreach object $object_id {
    course_catalog::add_relation -course_id $course_id -class_id $object
}

if { [string equal $return_url ""] } {
    ad_returnredirect "/courses/cc-admin/dotlrn-list?course_id=$course_id"
} else {
    ad_returnredirect "$return_url"
}
