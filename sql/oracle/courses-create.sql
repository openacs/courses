-- Course Catalog Data Model
-- author  Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
-- creation-date 2005-01-31

begin
  acs_rel_type.create_role(''c_catalog_role'', ''Course Catalog Role'', ''Course Catalog Role'');
  acs_rel_type.create_role(''dotlrn_class_role'', ''dotLRN Class Role'', ''dotLRN Class Role'');
  acs_rel_type.create_role(''dotlrn_com_role'', ''dotLRN Community Role'', ''dotLRN Community Role'');

  commit;
end;
/
show errors