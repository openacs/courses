<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>
<br>
#courses.this_course# <b>@rev_num@</b> 
<if @assoc_num@ eq 1>
    #courses.version#
</if>
<else>
    #courses.versions#
</else>

<if @assoc_num@ eq 0>
   #courses.has_no#
</if>
<else>
   <if @assoc_num@ eq 1>
       #courses.and_has_one#
   </if>
   <else>
       #courses.and_has# <b>@assoc_num@</b> #courses.to_dotlrn#
   </else>
</else>
<br>
<b>#courses.do_you_still#</b>
<br><br>
<formtemplate id="delete_course"></formtemplate>