ad_page_contract {
    Shows all associations that course_id has
    
    @author          Miguel Marin (miguelmarin@viaro.net)
    @author          Viaro Networks www.viaro.net
    @creation date   28-01-2005
} {
    { return_url "" }
    course_id:notnull
    course_key:notnull
}

set page_title "[_ courses.watch_assoc]"
set context [list [list course-list  "[_ courses.course_list]"] "[_ courses.watch_assoc]"]

set user_id [ad_conn user_id]

# Check if users has admin permission to edit course_catalog
permission::require_permission -party_id $user_id -object_id $course_id -privilege "admin"

db_multirow relations relation { }

