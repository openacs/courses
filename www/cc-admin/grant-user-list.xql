<?xml version="1.0"?>
<queryset>

<fullquery name="select_users">      
      <querytext>
	  select first_names, last_name, user_id as p_user_id
	  from cc_users where email = ''
      </querytext>
</fullquery>

<fullquery name="select_users_name">      
      <querytext>
	  select first_names, last_name, user_id as p_user_id
	  from cc_users where user_id <> :user_id
	  and (lower(first_names) like '%$user_name%'
   	  or lower(last_name) like '%$user_name%') and user_id in (
		select grantee_id from acs_permissions where privilege = 'create' and
	 	object_id = :cc_package_id
	  ) order by first_names, last_name
      </querytext>
</fullquery>

<fullquery name="select_users_email">      
      <querytext>
	  select first_names, last_name, user_id as p_user_id
	  from cc_users where user_id <> :user_id 
	  and lower(email) like '%$user_email%' and user_id in (
		select grantee_id from acs_permissions where privilege = 'create' and
	 	object_id = :cc_package_id
	  ) order by email
      </querytext>
</fullquery>

<fullquery name="select_users_name_email">      
      <querytext>
	  select first_names, last_name, user_id as p_user_id
	  from cc_users where user_id <> :user_id 
	  lower(first_names) like '%$user_name%' or lower(last_name) like '%$user_name%')
	  and lower(email) like '%$user_email%' and user_id in (
		select grantee_id from acs_permissions where privilege = 'create' and
	 	object_id = :cc_package_id
	  ) order by email
      </querytext>
</fullquery>

</queryset>
