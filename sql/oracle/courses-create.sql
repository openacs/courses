-- Course Catalog Data Model
-- author  Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
-- creation-date 2005-01-31

create table c_catalog (
	course_id	integer constraint c_catalog_fk
			references course_catalog
			constraint c_catalog_pk
			primary key
);


begin
  acs_rel_type.create_role(''c_catalog_role'', ''Course Catalog Role'', ''Course Catalog Role'');
  acs_rel_type.create_role(''dotlrn_class_role'', ''dotLRN Class Role'', ''dotLRN Class Role'');
  acs_rel_type.create_type (
    rel_type => 'courses_catalog_rel',
    pretty_name => 'Courses Catalog Relationship',
    pretty_plural => 'Courses Catalog Relationship',
    object_type_one => 'course_catalog',
    role_one => 'c_catalog_role',
    table_name => 'c_catalog',
    id_column => 'course_id',
    package_name => 'course_catalog_rel',
    min_n_rels_one => 0,
    max_n_rels_one => 1,
    object_type_two => 'dotlrn_class_instance',
    min_n_rels_two => 0,
    max_n_rels_two => 1
  );

  commit;
end;
/
show errors