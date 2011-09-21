<cfparam name="arguments.list" type="string" default="">
<cfparam name="arguments.delimiters" type="string" default=",">
<cfparam name="arguments.caseSensitive" type="boolean" default="false">
<cfparam name="arguments.multiList" type="boolean" default="false">

<cfif arguments.caseSensitive>
	<cfif arguments.multiList>
		<cfloop index="loc.singleValue" list="#arguments.value#" delimiters="#arguments.delimiters#">
			<cfif NOT listFind( arguments.list, loc.singleValue, arguments.delimiters )>
				<cfset arguments.message = "contains the value ""#xmlFormat( loc.singleValue )#"" that was rejected, the only valid values are: ""#arguments.list#"" (case sensitive)"><cfexit>
			</cfif>
		</cfloop>
	<cfelseif NOT listFind( arguments.list, arguments.value, arguments.delimiters )>
		<cfset arguments.message = "was rejected, the only valid values are: ""#arguments.list#"" (case sensitive)">
	</cfif>
	
<cfelse><!--- case-insensitive --->
	<cfif arguments.multiList>
		<cfloop index="loc.singleValue" list="#arguments.value#" delimiters="#arguments.delimiters#">
			<cfif NOT listFindNoCase( arguments.list, loc.singleValue, arguments.delimiters )>
				<cfset arguments.message = "contains the value ""#xmlFormat( loc.singleValue )#"" that was rejected, the only valid values are: ""#arguments.list#"""><cfexit>
			</cfif>
		</cfloop>
	<cfelseif NOT listFindNoCase( arguments.list, arguments.value, arguments.delimiters )>
		<cfset arguments.message = "was rejected, the only valid values are: ""#arguments.list#""">
	</cfif>
</cfif>

