ad_library {

    Tcl API for course_catalog store and manipulation

    @author Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
}

namespace eval course_catalog {}

ad_proc -private course_catalog::get_folder_id { } {
    Returns the folder_id of the folder with the name "Course Catalog"
} {
    return [db_string check_folder_name { } ]
}

ad_proc -private course_catalog::get_item_id { 
    -name:required
    {-parent_id ""}
 } {
    Returns the item_id in the CR with the name @name@ under folder course_catalog
    @name@         The name of the item id in the CR
    @parent_id@    The folder_id where the item is stored
} {
    if { [string equal $parent_id ""] } {
	set parent_id [course_catalog::get_folder_id]
    }

    return [db_string get_item_from_name { } ]
}

ad_proc -private course_catalog::set_live {
    -name:required
    -revision_id:required
} {
    Sets the live_revision to @revision_id@ where name in cr_items equals @name@
    @name@        The item name in CR
    @revision_id@ The revision to set as live
} {
    db_transaction {
	db_dml set_live_revision { }
    }
}


ad_proc -private course_catalog::rename {
    -item_id:required
    -name:required
} {
    Sets the item name to @name@ for given item_id
    @revision_id@ The item_id of the item in the CR
    @name@        The new name for the item in CR
} {
    db_transaction {
	db_dml set_item_name { }
    }
}


ad_proc -public course_catalog::add_relation {
    -course_id:required
    -class_id:required
} {
    Add a new relation between course_id from course_catalog and a class_instance_id from dotlrn
    @course_id The id of the course in course_catalog
    @class_id the class_instance_id of the class in dotlrn
} {
    db_exec_plsql add_relation { }
}

ad_proc -public course_catalog::has_relation {
    -course_id:required
} {
    Returns  the class_id of dotlrn_class_instance related to course_id, returns 0 otherwise.
    @course_id The id of the course in course_catalog
} {
    return [db_string has_relation { } -default 0]
}

ad_proc -public course_catalog::has_relation_rel_id {
    -course_id:required
} {
    Returns  the class_id of dotlrn_class_instance related to course_id, returns 0 otherwise.
    @course_id The id of the course in course_catalog
} {
    return [db_string has_relation_rel_id { } -default 0]
}


ad_proc -public course_catalog::check_live_latest {
    -revision_id:required
} {
    Deletes the row of course_catalog table and cr_revisions table where revision_id  = @course_id@
    @revision_id The id of the revision in cr_items
} {
    set live [db_string check_live { } -default 0]
    set latest [db_string check_latest { } -default 0] 
    if { [string equal $live "0"] && [string equal $latest "0"] } {
	return 1
    } else {
	return 0
    }
}

ad_proc -public course_catalog::delete_row {
    -course_id:required
} {
    Deletes the row of course_catalog table and cr_revisions table where revision_id  = @course_id@
    @course_id The id of the course in course_catalog
} {
    if { [course_catalog::check_live_latest -revision_id $course_id] } {
	db_transaction {
	    db_dml delete_row { }
	    db_dml delete_rev { }
	}
	course_catalog::delete_relation -course_id $course_id
    }
}

ad_proc -public course_catalog::delete_relation {
    -course_id:required
} {
    Deletes the relation of course_catalog and dotrln class
    @course_id The id of the object_id_one
} {
    set rel_id [course_catalog::has_relation_rel_id -course_id $course_id]
    if { ![string equal $rel_id "0"] } {
	db_exec_plsql remove_relation { }
    }
}