<?xml version="1.0"?>
<queryset>

    <fullquery name="get_dotlrn_classes">
        <querytext>
            select class_instance_id as class_id, department_name, term_name, class_name, pretty_name, url
	    from dotlrn_class_instances_full 
	    order by department_name, term_name, class_name, pretty_name
        </querytext>
    </fullquery>

</queryset>