-- Courses Catalog Relation Model
-- author Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
-- creation-date 2005-01-31


create table c_catalog (
	course_id	integer constraint c_catalog_fk
			references course_catalog
			constraint c_catalog_pk
			primary key
);

create function inline_0 ()
returns integer as '
begin
  PERFORM acs_rel_type__create_role(''c_catalog_role'', ''Course Catalog Role'', ''Course Catalog Role'');
  PERFORM acs_rel_type__create_role(''dotlrn_class_role'', ''dotLRN Class Role'', ''dotLRN Class Role'');

  PERFORM acs_rel_type__create_type (
      ''course_catalog_rel'',
      ''Course Catalog Relationship'',
      ''Course Catalog Relationship'',
      ''relationship'',
      ''c_catalog'',
      ''course_id'',
      ''course_catalog_rel'',
      ''course_catalog'',
      ''c_catalog_role'',
      0,
      1,
      ''dotlrn_class_instance'',
      ''dotlrn_class_role'',
      0,
      1
  );

  return 0;		
end;' language 'plpgsql';

select inline_0 ();

drop function inline_0 ();