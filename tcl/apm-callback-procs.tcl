# packages/course-catalog/tcl/apm-callbacks-procs.tcl 

ad_library {
    
    APM callback for course catalog
    
    @author Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation-date 2005-01-27
}

namespace eval courses {}

ad_proc -private courses::package_install {
} {
    create the CR type datamodel for the course catalog
    
    @author Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation-date 2005-01-27
} {
 
    # lets create the CR type tables to support the course catalog
    
    content::type::new -content_type "course_catalog" \
	-pretty_name "Course Catalog" \
	-pretty_plural "Courses Catalog" \
 	-table_name "course_catalog" \
	-id_column "course_id"

    # now set up the attributes that by default we need for the course
    content::type::attribute::new \
	-content_type "course_catalog" \
	-attribute_name "course_key" \
	-datatype "text" \
	-pretty_name "Course Key" \
	-pretty_plural "Course Key" \
	-sort_order 1 \
	-column_spec "varchar(50)"

    content::type::attribute::new \
	   -content_type "course_catalog" \
	   -attribute_name "course_name" \
	   -datatype "text" \
	   -pretty_name "Course Name" \
	   -sort_order 2 \
	   -column_spec "varchar(200)"

    content::type::attribute::new \
	-content_type "course_catalog" \
	-attribute_name "course_info" \
	-datatype "text" \
	-pretty_name "Course Information" \
	-sort_order 3 \
	-column_spec "varchar"

    content::type::attribute::new \
	-content_type "course_catalog" \
	-attribute_name "assessment_id" \
	-datatype "integer" \
	-pretty_name "Assessment ID" \
	-sort_order 4 \
	-column_spec "integer"

    set folder_id [content::folder::new -name "Course Catalog" -label "Course Catalog"]
    
    content::folder::register_content_type -folder_id $folder_id -content_type "course_catalog" 

}

ad_proc -private courses::package_uninstall {
} {
    drops the CR type datamodel for the course catalog
    
    @author Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation-date 2005-01-27
} {
    content::type::attribute::delete -content_type "course_catalog" -attribute_name "course_key" 
    content::type::attribute::delete -content_type "course_catalog" -attribute_name "course_name" 
    content::type::attribute::delete -content_type "course_catalog" -attribute_name "course_info" 
    content::type::attribute::delete -content_type "course_catalog" -attribute_name "assessment_id" 
    set folder_id [course_catalog::get_folder_id]
    content::folder::unregister_content_type -folder_id $folder_id -content_type "course_catalog"
    content::folder::delete -folder_id $folder_id -cascade_p "t"
    content::type::delete -content_type "course_catalog" 
}
