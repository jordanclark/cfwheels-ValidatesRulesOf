<cfparam name="arguments.telephone" type="string" default="phoneExt">
<cfparam name="arguments.divider" type="string" default="-">

<cfif arguments.autoFix>
	<cfset arguments.tmpExt = "">
	<cfset arguments.tmp = arguments.value>
	
	<!--- Replace all non-numeric characters from the string --->
	<cfif listLen( arguments.tmp, "ext" ) GT 1>
		<cfset arguments.tmpExt = reReplace( listLast( arguments.tmp, "ext" ), "[^0-9]", "", "all" )>
		<cfset arguments.tmp = listFirst( arguments.tmp, "ext" )>
	</cfif>
	<cfset arguments.tmp = reReplaceNoCase( arguments.tmp, "[^0-9]", "", "all" )>
	
	<cfswitch expression="#len( arguments.tmp )#">
		<cfcase value="7"><!--- XXX-XXXX --->
			<cfset arguments.tmp = left( arguments.tmp, 3 ) & "-" & right( arguments.tmp, 4 )>
		</cfcase>
		<cfcase value="10"><!--- XXX-XXX-XXXX --->
			<cfset arguments.tmp = left( arguments.tmp, 3 ) & "-" & mid( arguments.tmp, 4, 3 ) & "-" & right( arguments.tmp, 4 )>
		</cfcase>
		<!--- <cfcase value="10"><!--- (XXX) XXX-XXXX --->
			<cfset arguments.tmp = "(" & left( arguments.tmp, 3 ) & ") " & mid( arguments.tmp, 4, 3 ) & "-" & right( arguments.tmp, 4 )>
		</cfcase> --->
		<cfcase value="11"><!--- X-XXX-XXX-XXXX --->
			<cfset arguments.tmp = left( arguments.tmp, 1 ) & "-" & mid( arguments.tmp, 2, 3 ) & "-" & mid( arguments.tmp, 5, 3 ) & "-" & right( arguments.tmp, 4 )>
		</cfcase>
		<cfdefaultcase><!--- return a default value instead --->
			<cfset arguments.tmp = arguments.value>
		</cfdefaultcase>
	</cfswitch>
	
	<cfif len( arguments.tmpExt )>
		<cfset arguments.tmp = arguments.tmp & " x" & arguments.tmpExt>
	</cfif>
	
	<cfset arguments.value = arguments.tmp>
</cfif>

<cfswitch expression="#arguments.telephone#">

	<cfcase value="phoneStrict7">
		<cfif arguments.autoFix>
			<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9|#arguments.divider#]", "", "all" )>
		</cfif>
		<cfif NOT reFindNoCase( "^[0-9]{3}#arguments.divider#[0-9]{4}$", arguments.value )>
			<cfif arguments.mutable AND NOT arguments.autoFix>
				<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9|#arguments.divider#]", "", "all" )>
			</cfif>
			<cfset arguments.message = "must be formatted similar to: 123#arguments.divider#4567">
		</cfif>
	</cfcase>
	
	<cfcase value="phoneStrict10">
		<cfif arguments.autoFix>
			<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9|#arguments.divider#]", "", "all" )>
		</cfif>
		<cfif NOT reFindNoCase( "^[0-9]{3}#arguments.divider#[0-9]{3}#arguments.divider#[0-9]{4}$", arguments.value )>
			<cfif arguments.mutable AND NOT arguments.autoFix>
				<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9|#arguments.divider#]", "", "all" )>
			</cfif>
			<cfset arguments.message = "must be formatted similar to: 123#arguments.divider#456#arguments.divider#7890">
		</cfif>
	</cfcase>
	
	<cfcase value="phone">
		<cfif arguments.autoFix>
			<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9|#arguments.divider#]", "", "all" )>
		</cfif>
		<cfif NOT reFindNoCase( "^[0-9|#arguments.divider#]{7,12}$", arguments.value )>
			<cfif arguments.mutable AND NOT arguments.autoFix>
				<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9|#arguments.divider#]", "", "all" )>
			</cfif>
			<cfset arguments.message = "must be between 7 and 12 numbers long">
		</cfif>
	</cfcase>
	
	<cfcase value="phoneExt">
		<cfif arguments.autoFix>
			<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9| x#arguments.divider#]", "", "all" )>
		</cfif>
		<cfif NOT reFindNoCase( "^[0-9]{3}#arguments.divider#[0-9]{3}#arguments.divider#[0-9]{4}( x[0-9]{1,6})?$", arguments.value )>
			<cfif arguments.mutable AND NOT arguments.autoFix>
				<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9| x#arguments.divider#]", "", "all" )>
			</cfif>
			<cfset arguments.message = "must be entered like: 123#arguments.divider#456#arguments.divider#7890 or 123#arguments.divider#456#arguments.divider#7890 x12345">
		</cfif>
	</cfcase>
	
</cfswitch>