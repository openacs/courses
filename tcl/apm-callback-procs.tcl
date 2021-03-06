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
	-datatype "string" \
	-pretty_name "Course Key" \
	-pretty_plural "Course Key" \
	-sort_order 1 \
	-column_spec "varchar(50)"

    content::type::attribute::new \
	-content_type "course_catalog" \
	-attribute_name "course_name" \
	-datatype "string" \
	-pretty_name "Course Name" \
	-sort_order 2 \
	-column_spec "varchar(200)"

    content::type::attribute::new \
	-content_type "course_catalog" \
	-attribute_name "course_info" \
	-datatype "text" \
	-pretty_name "Course Information" \
	-sort_order 3 \
	-column_spec "text"

    content::type::attribute::new \
	-content_type "course_catalog" \
	-attribute_name "assessment_id" \
	-datatype "integer" \
	-pretty_name "Assessment ID" \
	-sort_order 4 \
	-column_spec "integer"

    # To store the courses in the content repository
    set folder_id [content::folder::new -name "Course Catalog" -label "Course Catalog"]
    content::folder::register_content_type -folder_id $folder_id -content_type "course_catalog" 
    
    # To associate one course to dotlrn class
    rel_types::new -role_one c_catalog_role -role_two dotlrn_class_role course_catalog_class_rel \
	"Course Catalog Class" "Course Catalog Class" course_catalog 0 1 dotlrn_class_instance 0 1
    # To associate one course to dotrln community
    rel_types::new -role_one c_catalog_role -role_two dotlrn_com_role course_catalog_dotcom_rel \
	"Course Catalog Community" "Course Catalog Community" course_catalog 0 1 dotlrn_club 0 1
}


ad_proc -private courses::package_mount {
    -package_id
    -node_id
} {
    create the category tree for dotlrn catalog
    
    @author Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation-date 11-02-2005
} {
    # To categorize courses
    set tree_id [category_tree::add -name "dotlrn-course-catalog"]
    category_tree::map -tree_id $tree_id -object_id $package_id -assign_single_p "t"
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
