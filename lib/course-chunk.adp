<table>
<tr>
   <td>
   <if @edit@ eq yes>
   <div align="right">
	<a href=course-add-edit?course_id=@course_id@&return_url=@return_url@&mode=edit \
	title="#courses.new_ver#"><img border=0 src=/resources/Edit16.gif></a>
   </div>
   </if>
   </td>
  <td>
    <b>#courses.course_key#</b>
  </td>
  <td>
    <if @edit@ eq yes>
    <a href="revision-list?course_key=@course_key@&return_url=$return_url&course_id=@course_id@" title="#courses.see_all_rev#">@course_key@</a></if><else>@course_key@</else>
   </td>
</tr>
<tr><td></td>
    <td><b>#courses.course_name#</b></td><td>@name@</td>
</tr>
<tr><td></td>
    <td><b>#courses.course_info#</b></td><td>@info@</td>
</tr>
<tr><td></td>
    <td><b>#courses.asm#:</b></td><td>@asm@</td>
</tr>
<tr><td></td>
    <td>
	<b>#courses.dotlrn#</b>
    </td>
    <td>
	<if @rel@ eq 0>
	   #courses.no# 
	  <if @edit@ eq "yes">
	     <if @dotlrn_url@ eq "/dotlrn">
             (<a href="dotlrn-list?course_id=@course_id@&course_key=@course_key@&course_name=@name@&return_url=@return_url@" title="#courses.associate_this#"><i>#courses.associate#</i></a>)</if>
          </if>
	</if>
	<else>
	   <if @index@ eq "yes">
	       #courses.yes# (<a href="cc-admin/watch-association?course_id=@course_id@&course_key=@course_key@&return_url=@return_url@&course_name=@name@" title="#courses.watch_assoc#"><i>#courses.watch#</i></a>)
	   </if>
	   <else>
	       #courses.yes# (<a href="watch-association?course_id=@course_id@&course_key=@course_key@&return_url=@return_url@&course_name=@name@" title="#courses.watch_assoc#"><i>#courses.watch#</i></a>)
	   </else>
	</else>
    </td>
</tr>
<tr><td></td><td></td>
<td>
   <if @edit@ eq no>
      <if @index@ eq "yes">
	<if @asmid@ gt "-1">
	    <a class="button" href="/assessment/assessment?assessment_id=@asmid@">#courses.enroll#</a>
	</if>
      </if>
      <else>
         <if @course_id@ eq @live_revision@>
	     <img border=0 src="/courses/images/live.gif">   
         </if>
         <else>
	     <a href="go-live?course_key=@course_key@&revision_id=@course_id@" title="#courses.make_live#"><img border=0 src="/courses/images/golive.gif"></a>
         </else>
      </else>
   </if>
   <else>
	<a class=button href="grant-user-list?object_id=@item_id@&creation_user=@creation_user@&course_key=@course_key@" title="#courses.grantrevoke#">#courses.manage_per#</a>
         <a class=button href="course-delete?object_id=@item_id@&creation_user=@creation_user@&course_key=@course_key@" title="#courses.delete_this#">#courses.delete#</a>
	<if @category_p@ eq "-1">
	   <a class=button href="course-categorize?course_id=@course_id@&name=@name@">#courses.categorize#</a>
	</if>
   </td>
   </else>
</tr>
</table>
<br>
