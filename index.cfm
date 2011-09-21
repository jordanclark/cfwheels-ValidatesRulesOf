<cfoutput>

<style>
<cfinclude template="base.css">
</style>

<h1>ValidatesRulesOf 0.2</h1>

<p>This plugin adds additional object validation rules to the model layers. There are 60 built-in validations that can be run, and most have multiple additional arguments. The benefit of using rules validation is you can very easily chain multiple rules to be tested on a single field. Many rules also have the ability to "autoFix" the input, meaning stripping out invalid values or reformatting the data. Error messages are built into the rules, so instead of having 1 generic error message the rule can return a customized error which helps users correct mistakes. You can also easily create your own rules in just a few lines of code to override or agument the built-in validations with your own custom logic or error messages/</p>

<h2>Notes</h2>

<p>Built-in rules are stored in the <code>/plugins/ValidatesRulesOf/rules/</code> folder, your own customized rules can be stored in <code>/rules/</code> (on the same level as <code>/models/</code> or <code>/views/</code>).</p>

<h2>This plugin changes all validation methods behaviour</h2>
<p>
	The validation of required="true" is very similar to <code>validatesPresenceOf</code> that is built into wheels and can't easily be disabled.
	Instead I've changed validation routines to only return 1 error message per property, I don't think more are useful to users.<br />
	To go back to the original behaviour change this setting in <code>/config/settings.cfm</code>:
	<code class="block">&lt;cfset set( multipleValidationErrors=true )&gt;</code>
</p>

<h2>Function Syntax</h2> 
<p><code> ValidatesRulesOf([ <em>properties</em>, <em>rules</em>, <em>required</em>, <em>mutable</em>, <em>autoFix</em>, <em>default</em>, <em>defaultOnError</em>, <em>multiple</em>, <em>prefixLabel</em>, <em>sentence</em>, <em>when</em>, <em>condition</em>, <em>unless</em> ])</code></p> 
 
<h2>Parameters</h2> 
<table> 
<thead> 
	<tr> 
		<th>Parameter</th> 
		<th>Type</th> 
		<th>Required</th> 
		<th>Default</th> 
		<th>Description</th> 
	</tr> 
</thead> 
<tbody> 

	<tr > 
		<td valign="top"><code>properties</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top" class="required">No</td> 
		<td valign="top"><code></code></td> 
		<td valign="top">  Name of property or list of property names to validate against (can also be called with the <code>property</code> argument).</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>rules</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top" class="required">No</td> 
		<td valign="top"><code></code></td> 
		<td valign="top">  List of rules to validate each property against.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>required</code></td> 
		<td valign="top"><code>boolean</code></td> 
		<td valign="top" class="required">No</td> 
		<td valign="top"><code>true</code></td> 
		<td valign="top">If the property is required, if not and the field is empty the rules will be skipped (similar to wheel's <code>AllowBlank</code>).</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>mutable</code></td> 
		<td valign="top"><code>boolean</code></td> 
		<td valign="top" class="required">No</td> 
		<td valign="top"><code>true</code></td> 
		<td valign="top">If the rules can change the input value, this necessary for <code>autoFix</code> and <code>default</code>.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>autoFix</code></td> 
		<td valign="top"><code>boolean</code></td> 
		<td valign="top" class="required">No</td> 
		<td valign="top"><code>false</code></td> 
		<td valign="top">If rules should first try to auto-correct the problem before throwing an error if the property is <code>mutable</code>. This is handy to help correct mistakes for users, but it can also result in silent mistakes, where the user entered a value that was corrected but they didn't know or want it changed.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>default</code></td> 
		<td valign="top"><code>any</code></td> 
		<td valign="top" class="required">No</td> 
		<td valign="top"><code></code></td> 
		<td valign="top">If no value is provided then the property is updated to this default value if the property is <code>mutable</code>.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>defaultOnError</code></td> 
		<td valign="top"><code>boolean</code></td> 
		<td valign="top" class="required">No</td> 
		<td valign="top"><code>true</code></td> 
		<td valign="top">If an error occurs in validation and a <code>default</code> value is given, and the property is <code>mutable</code>, then the property will be changed to this value. This is useful as a failsafe.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>prefixLabel</code></td> 
		<td valign="top"><code>boolean</code></td> 
		<td valign="top" class="required">No</td> 
		<td valign="top"><code>true</code></td> 
		<td valign="top">Prefix the error message with the property name, this is good when displaying error messages in a box above the form, however if you are displaying errors inline in the form then consider disabling this.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>sentence</code></td> 
		<td valign="top"><code>boolean</code></td> 
		<td valign="top" class="required">No</td> 
		<td valign="top"><code>true</code></td> 
		<td valign="top">End the error message with a period "." to make it a sentence.</td> 
	</tr> 

	<tr > 
		<td valign="top"><code>when</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top" class="required">No</td> 
		<td valign="top"><code>onSave</code></td> 
		<td valign="top">  Pass in <code>onCreate</code> or <code>onUpdate</code> to limit when this validation occurs (by default validation will occur on both create and update, i.e. <code>onSave</code>).</td> 
	</tr> 

	<!--- <tr class="highlight"> 
		<td valign="top"><code>allowBlank</code></td> 
		<td valign="top"><code>boolean</code></td> 
		<td valign="top" class="required">No</td> 
		<td valign="top"><code>false</code></td> 
		<td valign="top">  If set to <code>true</code>, validation will be skipped if the property value is an empty string or doesn't exist at all. This is useful if you only want to run this validation after it passes the <a href="/docs/1-1/function/validatespresenceof"><code>validatesPresenceOf()</code></a> test, thus avoiding duplicate error messages if it doesn't.</td> 
	</tr>  --->

	<tr > 
		<td valign="top"><code>condition</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top" class="required">No</td> 
		<td valign="top"><code></code></td> 
		<td valign="top">  String expression to be evaluated that decides if validation will be run (if the expression returns <code>true</code> validation will run).</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>unless</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top" class="required">No</td> 
		<td valign="top"><code></code></td> 
		<td valign="top">  String expression to be evaluated that decides if validation will be run (if the expression returns <code>false</code> validation will run).</td> 
	</tr> 
	
</tbody> 
</table> 


<h2>Rules</h2> 
<table> 
<thead> 
	<tr> 
		<th>Name</th> 
		<th>AutoFix</th> 
		<th>Parameters</th> 
		<th>Description</th> 
	</tr> 
</thead> 
<tbody> 

	<tr class="highlight"> 
		<td valign="top"><code>alpha</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code></code></td> 
		<td valign="top">Checks the property to be alpha (A-Z).</td> 
	</tr> 
	
	<tr class="highlight"> 
		<td valign="top"><code>alphaNumeric</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code></code></td> 
		<td valign="top">Checks the property to be alpha-numeric (A-Z0-9).</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>boolean</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[booleanType=trueFalse]</code></td> 
		<td valign="top">Checks the property is boolean, possible types are: <code>trueFalse</code>, <code>yesNo</code>, <code>onOff</code>, <code>bit</code>.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>condition</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>condition</code><br /><code>[conditionError]</code></td> 
		<td valign="top">Throws an error if the condition is true, the error message is customizable.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>contains</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>contains</code><br /><code>[caseSensitive=false]</code><br /><code>[containsReplace]</code><br /><code>[containsError]</code> </td> 
		<td valign="top">Throws an error if the property contains a value, if you include <code>[containsReplace]</code> the value will be replaced with this and the error message is customizable.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>country</code></td> 
		<td valign="top">No</td>
		<td valign="top"><code>[countryList]</code></td> 
		<td valign="top">Checks the property matches one of the 2 char 200+ country codes, or specify your own list.</td> 
	</tr> 
	
	<tr class="highlight"> 
		<td valign="top"><code>creditcardExpiry</code></td> 
		<td valign="top">No</td>
		<td valign="top"><code></code></td> 
		<td valign="top">Checks the property is a date in the future, which is what a valid credit card expiry date should be.</td> 
	</tr> 
	
	<tr class="highlight"> 
		<td valign="top"><code>creditcardMod9</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>ccType</code></td> 
		<td valign="top">Checks the property matches creditcard Mod9 verification and that the card type matches the number.</td> 
	</tr> 
	
	<tr class="highlight"> 
		<td valign="top"><code>creditcardNumber</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code></code></td> 
		<td valign="top">Checks the property matches creditcard verification using CF isValid().</td> 
	</tr>  
	
	<tr class="highlight"> 
		<td valign="top"><code>creditcardType</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[cardTypes=3]</code></td> 
		<td valign="top">Checks the property matches a list of possible credit card types, the types are<br /> 1= <code>m,a,v,d</code><br /> 2= <code>mc,am,vi,ds</code><br /> 3= <code>mc,amex,visa,disc</code><br /> 4= <code>mastercard,amex,visa,discover</code></td> 
	</tr> 
	
	<tr class="highlight"> 
		<td valign="top"><code>date</code></td> 
		<td valign="top">No</td>
		<td valign="top"><code>[parseDate=false]</code></td> 
		<td valign="top">Checks the property is a date, and can also try to <code>parseDate()</code> first.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>dateRange</code></td> 
		<td valign="top">No</td>
		<td valign="top"><code>[dateMin]</code><br /><code>[dateMax]</code></td> 
		<td valign="top">Checks the property is between the date ranges.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>dollar</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[dollarSign=true]</code><br /><code>[allowNegative=true]</code></td> 
		<td valign="top">Checks the property is a dollar value like "$9.99" or "9.99" or "-9.99" depending on parameters.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>ean</code></td> 
		<td valign="top">No</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property could be an EAN number, however does not perform a MOD check.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>email</code></td> 
		<td valign="top">No</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property is an email, it returns more insightful error messages for incorrect email addresses.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>fileName</code></td> 
		<td valign="top">No</td>
		<td valign="top"><code>[extension]</code></td> 
		<td valign="top">Checks the property is a valid filename that doesn't have invalid characters and optionally that the file extension matches.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>filter</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[filter]</code><br /><code>[filterAdd]</code></td> 
		<td valign="top">Filters the string against a list of swear words, racist or hateful words. You can provide your own list of words or add additional words. The restricted words are replaced with ****</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>float</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property is a decimal numbers like 132.45</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>hexCode</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property only contains hexidecimal letters (0-9) and letters (A-F)</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>htmlRestriction</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[allowTags]</code></td> 
		<td valign="top">Checks the property only contains a limited set of HTML tags which by default are: <code>B, STRONG, EM, I, FONT, UL, OL, LI, BR, P, DIV, SPAN, ADDRESS</code></td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>htmlSafe</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property doesn't contain any really bad HTML tags which by default are: <code>OBJECT, EMBED, SCRIPT, APPLET, META, LINK, FRAME, FRAMESET, IFRAME</code></td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>htmlStrict</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property doesn't contain any HTML tags at all.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>integer</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property is an integer (0-9)</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>isbn</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property is an ISBN code</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>length</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[length]</code><br /><code>[min]</code><br /><code>[max]</code><br /><code>[lengthUnits=number]</code></td> 
		<td valign="top">Checks the property string length, similar to <code>validatesLengthOf</code>. <code>length</code> can also be a range like: "2-5" </td> 
	</tr> 


	<tr class="highlight"> 
		<td valign="top"><code>listExclude</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>list</code><br /><code>[delimiters=,]</code><br /><code>[caseSensitive=false]</code><br /><code>[multiList=false]</code></td> 
		<td valign="top">Checks the property matches a list of excluded values, throws an error if it matches.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>listMatch</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>list</code><br /><code>[delimiters=,]</code><br /><code>[caseSensitive=false]</code><br /><code>[multiList=false]</code></td> 
		<td valign="top">Checks the property matches a list of possible values.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>listLength</code></td> 
		<td valign="top">No</td>
		<td valign="top"><code>[listLength]</code><br /><code>[listMin]</code><br /><code>[listMax]</code><br /><code>[delimiters=,]</code></td> 
		<td valign="top">Checks the property string length, similar to <code>validatesLengthOf</code>. <code>length</code> can also be a range like: "2-5" </td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>mask</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>mask</code><br /><code>[maskError=normal]</code></td> 
		<td valign="top">Checks the property matches an input mask. "A" = Alpha, "X" = AlphaNumeric, "0" = Numeric, anything else matches itself. Examples postal code: "A0A-0A0" or phone number: "000-000-0000". <code>maskError</code> = "normal" gives a generic error message, "detailed" says exactly which character doesn't match.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>mssql</code></td> 
		<td valign="top">No</td>
		<td valign="top"><code>dataType</code><br /><code>[dataError=normal]</code></td> 
		<td valign="top">Checks the property against the value ranges that are storeable in SQL Server data types. Supported types are: <code>Decimal, Float, Real, BigInt, Int, SmallInt, TinyInt, Money, SmallMoney, Numeric, Bit, DateTime, SmallDateTime, Text, NText, VarChar, NVarChar, Char, NChar</code>.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>name</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property is a name, meaning letters, spaces and punctuations.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>nameEmail</code></td> 
		<td valign="top">No</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property is a full name and email address like: "Fred Flintstone" <fred@bedrock.com></td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>notZero</code></td> 
		<td valign="top">No</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property is not "0", simple check.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>number</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property is a number, which can be positive, negative and have decimals.</td> 
	</tr> 
	
	<tr class="highlight"> 
		<td valign="top"><code>password</code></td> 
		<td valign="top">No</td>
		<td valign="top"><code>passwordType=standard</code><br /><code>[verifyProperty]</code><br /><code>[caseSensitive=false]</code></td>
		<td valign="top">Checks the property matches a type of password. <code>verifyProperty</code> checks that the value of this property matches another property for password confirmation. "standard" = letters, numbers, underscore, hyphens. "withNumbers" = alpha numeric. "withSymbols" = alpha numeric + symbols.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>postalCode</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[postalDivider=" "]</code><br /><code>[autoFormat=true]</code></td> 
		<td valign="top">Checks the property is a Canadian postal code, autoFormat will reformat the value.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>province</code></td> 
		<td valign="top">No</td>
		<td valign="top"><code>[provinceList]</code></td> 
		<td valign="top">Checks the property is a 2 char Canadian province from the list, or provide your own acceptable list.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>range</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>range</code><br /><code>[rangeType=number]</code></td> 
		<td valign="top">Checks the property is within the numeric range, such as 5-10. rangeType also accepts: <code>dollar, decimal, number, year</code> or your own custom type like <code>feet or inches</code> for better error messages.</td> 
	</tr> 
	
	<tr class="highlight"> 
		<td valign="top"><code>sqlSafe</code></td> 
		<td valign="top">No</td>
		<td valign="top"><code>[sqlSafe]</code><br /><code>[sqlKeywords]</code></td> 
		<td valign="top">Checks the property against 3 checks. "keywords" checks for <code>DELETE, INSERT, SELECT, UPDATE, DROP, ALTER, CREATE</code>, "functions" checks for function names, "escape" replaces all single quotes and SQL comments.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>state</code></td> 
		<td valign="top">No</td>
		<td valign="top"><code>[stateList]</code></td> 
		<td valign="top">Checks the property is a 2 char US State from the list, or provide your own acceptable list.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>stateProvince</code></td> 
		<td valign="top">No</td>
		<td valign="top"><code>[stateList]</code><br /><code>[provinceList]</code></td> 
		<td valign="top">Checks the property is a 2 char US State or 2 char Canadian Province from the lists, or provide your own acceptable lists.</td> 
	</tr> 
	
	<tr class="highlight"> 
		<td valign="top"><code>string</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[noSpaces=false]</code></td> 
		<td valign="top">Checks the property is a string.</td> 
	</tr> 
	
	<tr class="highlight"> 
		<td valign="top"><code>telephone</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[telephone=phone]</code><br /><code>[divider=-]</code></td> 
		<td valign="top">Checks the property is a telephone number, different number formats are:<br /><code>phone</code>= Any number 7-12 digits long<br /><code>phoneExt</code> = 999-999-9999 x9999 (extension is optional)<br />(<code>phoneStrict7</code> = 999-9999<br /><code>phoneStrict10</code> = 999-999-9999<br /></td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>telephoneFakes</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[telephoneFakes]</code><br /><code>[divider=-]</code></td> 
		<td valign="top">Checks the property is not an obviously fake telephone number like 000-000-0000, 333-333-3333, 123-456-7890, etc</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>text</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property only contains printable characters.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>upc</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property is UPC product code, it also does a MOD check.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>url</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property is a URL.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>userName</code></td> 
		<td valign="top">No</td>
		<td valign="top"></td> 
		<td valign="top">Checks the property only contains letters and numbers plus underscores or hyphens.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>wordCount</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[wordCount]</code><br /><code>[wordMin]</code><br /><code>[wordMax]</code></td> 
		<td valign="top">Checks the property string's word count is within the range, handy to use for contact forms instead of a specific character limit.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>zipCode</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[zipDivider=-]</code><br /><code>[autoFormat=true]</code></td> 
		<td valign="top">Checks the property is a US 5 or 9 char zip code. autoFormat strips and reformats the input so it is perfectly consistent.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>zipFakes</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[zipFakes]</code></td> 
		<td valign="top">Checks the property is not an obviously fake zip code like 11111, 12345, 99999, etc.</td> 
	</tr> 

	<tr class="highlight"> 
		<td valign="top"><code>zipPostal</code></td> 
		<td valign="top">Yes</td>
		<td valign="top"><code>[zipDivider=-]</code><br /><code>[postalDivider=" "]</code><br /><code>[autoFormat=true]</code></td> 
		<td valign="top">Checks the property is a US 5 or 9 char zip code or Canadian Postal code. autoFormat strips and reformats the input so it is perfectly consistent.</td> 
	</tr> 

</tbody> 
</table> 


<h2>Complex Data Rules</h2> 
<table> 
<thead> 
	<tr> 
		<th>Name</th>
		<th>Parameters</th> 
		<th>Description</th> 
	</tr> 
</thead> 
<tbody> 

	<tr class="highlight"> 
		<td valign="top"><code>array</code></td> 
		<td valign="top"><code>[length]</code><br /><code>[min]</code><br /><code>[max]</code></td> 
		<td valign="top">Checks the property is a CF Array, and checks the length of the array with the optional parameters</td> 
	</tr> 
	<tr class="highlight"> 
		<td valign="top"><code>binary</code></td> 
		<td valign="top"></td> 
		<td valign="top">Checks the property is binary</td> 
	</tr> 
	<tr class="highlight"> 
		<td valign="top"><code>object</code></td> 
		<td valign="top"></td> 
		<td valign="top">Checks the property is a CF Object</td> 
	</tr> 
	<tr class="highlight"> 
		<td valign="top"><code>query</code></td> 
		<td valign="top"></td> 
		<td valign="top">Checks the property is a CF Query</td> 
	</tr> 
	<tr class="highlight"> 
		<td valign="top"><code>structure</code></td> 
		<td valign="top"></td> 
		<td valign="top">Checks the property is a CF Structure</td> 
	</tr> 
	<tr class="highlight"> 
		<td valign="top"><code>WDDX</code></td> 
		<td valign="top"></td> 
		<td valign="top">Checks the property is a WDDX string</td> 
	</tr> 
	

</tbody> 
</table> 


<h2>No-Error Rules (for reformatting properties)</h2> 
<table> 
<thead> 
	<tr> 
		<th>Name</th> 
		<th>Parameters</th> 
		<th>Description</th> 
	</tr> 
</thead> 
<tbody> 

	<tr class="highlight"> 
		<td valign="top"><code>case</code></td> 
		<td valign="top"><code>case</code></td>
		<td valign="top">Changes the property to <code>upper</code> or <code>lower</code>.</td> 
	</tr> 
	
	<tr class="highlight"> 
		<td valign="top"><code>replace</code></td> 
		<td valign="top"><code>[caseSensitive=false]</code></td>
		<td valign="top">Changes the property with a series of find and replace statemets, just input the arguments as pairs of <code>findX</code> / <code>replaceX</code> or <code>reFindX</code> / <code>reReplaceX</code> like:<br /><code>find1="small", replace1="big", find2="medium", replace2="huge"</code></td> 
	</tr> 

</tbody> 
</table> 

<br />

<h2>Configuration:</h2>

<p>You can specify default values for validation, if not provided the defaults will be:</p>

<pre>
&lt;!--- in your settings.cfm ---&gt;
&lt;cfset set(
	functionName="validatesRulesOf"
,	required="true"
,	mutable="true"
,	autoFix="false"
,	defaultOnError="true"
,	stopOnError="true"
,	prefixLabel="true"
,	sentence="true"
,	message="is a required field that was skipped"
}&gt;
</pre>

<h2>Usage Example:</h2>

<pre>
&lt;!--- in your model ---&gt;
&lt;cfset validatesRulesOf(property="firstname,lastname",rules="length,name",length="2-25",required=true)&gt;
&lt;cfset validatesRulesOf(property="email",rules="length,email",length="6-50")&gt;
&lt;cfset validatesRulesOf(property="phone",rules="length,telephone",telephone="us-phone",max=20)&gt;
&lt;cfset validatesRulesOf(property="age",rules="integer,range",range="14-100",rangeType="years")&gt;
&lt;cfset validatesRulesOf(property="comment",rules="length,wordCount,htmlStrict",max=1000,wordCount=200)&gt;
</pre>

<h2>Uninstallation:</h2>
<p>
To uninstall this plugin, simply delete the /plugins/ValidatesRulesOf-0.2.zip file.
</p>

<h2>Credits</h2>
<p>
	This plugin was created by <a href="http://www.imagineer.ca/">Jordan Clark</a>
</p>
<p>
	To submit an issue or fork this plugin, visit the
	<a href="http://github.com/jordanclark/cfwheels-ValidatesRulesOf">jordanclark/cfwheels-ValidatesRulesOf</a>
	repository on GitHub.
</p>

<h2>Disclaimer</h2>
<p>Remember that you use this at your own risk and I'm not responsible for anything. Please don't sue me :)</p>
</cfoutput>