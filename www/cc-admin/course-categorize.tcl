ad_page_contract {
    Categorize one course
    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   10-02-2005
} {
    course_id:notnull
    name:notnull
}

set user_id [ad_conn user_id]
set context [list "[_ courses.categorize] $name"]
set page_title "[_ courses.categorize] $name"
set return_url "course-list"


ad_form -export { name } -name course_categorize -cancel_url "course-list" -form {
    {course_id:text(hidden) 
	{ value $course_id }
    }
    {category_ids:integer(category),multiple
	{label "[_ courses.categories]"}
	{html {size 4}}
	{value "-1"}
   }
} -on_submit {
    category::map_object -remove_old -object_id $course_id $category_ids
} -after_submit {
    ad_returnredirect "course-list"
}
