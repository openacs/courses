ad_library {

    Tcl API for course_catalog store and manipulation

    @author Miguel Marin (miguelmarin@viaro.net) 
    @Viaro Networks (href=www.viaro.net>www.viaro.net)    
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

ad_proc -public course_catalog::get_creation_user { 
    -object_id:required
} {
    Returns the creation_user of the object_id, returns -1 otherwise
    @object_id@    
} {
    return [db_string get_creation_user { } -default -1]
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


ad_proc -private course_catalog::add_relation {
    -course_id:required
    -class_id:required
} {
    Add a new relation between course_id from course_catalog and a class_instance_id from dotlrn
    @course_id The id of the course in course_catalog
    @class_id the class_instance_id of the class in dotlrn
} {
    db_exec_plsql add_relation { }
}

ad_proc -private course_catalog::has_relation_rel_id {
    -course_id:required
} {
    Returns  the class_id of dotlrn_class_instance related to course_id, returns 0 otherwise.
    @course_id The id of the course in course_catalog
} {
    return [db_string has_relation_rel_id { } -default 0]
}

ad_proc -private course_catalog::has_relation {
    -course_id:required
} {
    Returns 1 if there is a class_id of dotlrn_class_instance related to course_id, returns 0 otherwise.
    @course_id The id of the course in course_catalog
} {
    if { [db_string has_relation { } -default 0] == 0 } {
	return 0
    } else {
	return 1
    }
}


ad_proc -private course_catalog::com_has_relation {
    -community_id:required
} {
    Returns 1 if there is a community of dotlrn related to course_id, returns 0 otherwise.
    @community_id The id of the community in dotlrn
} {
    if { [db_string com_has_relation { } -default 0] == 0 } {
	return 0
    } else {
	return 1
    }
}


ad_proc -private course_catalog::check_live_latest {
    -revision_id:required
} {
    Checks if @revision_id@ is the live revision or the latest revision in cr_items
    @revision_id@
} {
    set live [db_string check_live { } -default 0]
    set latest [db_string check_latest { } -default 0] 
    if { [string equal $live "0"] && [string equal $latest "0"] } {
	return 1
    } else {
	return 0
    }
}

ad_proc -private course_catalog::delete_row {
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

ad_proc -private course_catalog::delete_relation {
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

ad_proc -private course_catalog::grant_permissions {
    -party_id:required
    -object_id:required
    -creation_user:required
} {
    Gives admin permission to @party_id@ over @object_id@ and over all assessment_id created
    by @creation_user@
    @party_id@       The user_id to give permissions
    @object_id@      The course_id that the @party_id@ will have permissions on
    @creation_user@  The user_id of the user that creates the course_id
} {
    permission::grant -party_id $party_id -object_id $object_id  -privilege "admin"
    set asm_package_id [apm_package_id_from_key assessment]

    db_foreach assessment { } {
    	if {[permission::permission_p -party_id $creation_user -object_id $assessment_id -privilege "admin"] == 1} {
	    permission::grant -party_id $party_id -object_id $assessment_id  -privilege "admin"
	}
    } 
}

ad_proc -private course_catalog::revoke_permissions {
    -party_id:required
    -object_id:required
    -creation_user:required
} {
    Revokes  admin permission to @party_id@ over @object_id@ and over all assessment_id created
    by @creation_user@
    @party_id@       The user_id to revoke permissions
    @object_id@      The course_id over wich @party_id@ has permissions on
    @creation_user@  The user_id of the user that creates the course_id
} {
    permission::revoke -party_id $party_id -object_id $object_id  -privilege "admin"
    set asm_package_id [apm_package_id_from_key assessment]
    
    db_foreach assessment { } {
	if { [permission::permission_p -party_id $creation_user -object_id $assessment_id -privilege admin] == 1 } {
	    permission::revoke -party_id $party_id -object_id $assessment_id  -privilege "admin"
	}
    }
}