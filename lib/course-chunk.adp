<table>
<tr>
   <td>
   <if @edit@ eq yes>
   <div align="right">
	<a href=add-edit-course?course_id=@course_id@&return_url=@return_url@&mode=edit \
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
	  <if @edit@ eq yes>
	     <if @dotlrn_url@ eq "/dotlrn">
             (<a href="dotlrn-list?course_id=@course_id@&course_key=@course_key@&return_url=@return_url@" title="#courses.associate_this#"><i>#courses.associate#</i></a>)</if>
          </if>
	</if>
	<else>
	   #courses.yes# (<a href="watch-association?course_id=@course_id@&course_key=@course_key@&return_url=@return_url@" title="#courses.watch_assoc#"><i>#courses.watch#</i></a>)
	</else>
    </td>
</tr>
<tr><td></td><td></td>
<td>
   <if @edit@ eq no>
      <if @course_id@ eq @live_revision@>
	   <img border=0 src="/courses/images/live.gif">   
      </if>
      <else>
	   <a href="go-live?course_key=@course_key@&revision_id=@course_id@" title="#courses.make_live#"><img border=0 src="/courses/images/golive.gif"></a>
      </else>
   </if>
   <else>
	<a class=button href="grant-user-list?object_id=@item_id@&creation_user=@creation_user@&course_key=@course_key@">#courses.manage_per#</a>
   </else>
</td></tr>
</table>
<br>
