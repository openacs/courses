<?xml version="1.0"?>
<queryset>

<fullquery name="select_users">      
      <querytext>
	  select first_names, last_name, user_id as p_user_id
	  from cc_users where user_id <> :user_id
      </querytext>
</fullquery>

</queryset>
