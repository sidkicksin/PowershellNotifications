

#_________________________Function to connect to crm d365 with Oauth______________________________


#This function will connect to crm d365 using Connect-CrmOnline cmdlet.
#Taking the ID and ClientSecret and will build a connection with crm.

function Get-Connection{

#User logging credentials
$oAuthClientId = ""
$encryptedClientSecret = ""

#__________Connecting to Source CRM____________.
Connect-CrmOnline -ClientSecret $encryptedClientSecret -OAuthClientId $oAuthClientId -ServerUrl ""

}

 







 #_________________Funtion to delete notification____________________________________________
#This function will be used to delete a notification record in crm for all users satifying the condition. 
#Remove-Notification will first retrive all the notification records using Get-CrmRecords cmdlet,
#then it will delete the notification for all the users which satisfy if condition.
function Remove-Notification {


#Retrieve all users of Pimco Dynamics Crm365.
$Notifications = Get-CrmRecords -conn $conn -EntityLogicalName appnotification -Fields title -TopCount 100
       

#Delete notification matching the specific conditions
for($i = 0; $i -lt $Notifications.Values.appnotificationid.length; $i++) {

if($Notifications.Values.title[$i] -eq "test11"){
 
try{    
$Delete = Get-CrmRecord -conn $conn -EntityLogicalName appnotification -Id $Notifications.Values.appnotificationid[$i] -Fields title
$Notifications.Values.appnotificationid[$i]
Remove-CrmRecord -conn $conn -CrmRecord $Delete
}

catch {
   "An Error Occured"

}
}
}


}









#__________________________Function to create notifications________________________________________

#This function will be used to create a notification record in crm for all users satifying the condition. 
#Set-Notification will first retrive all the users of crm using Get-CrmRecords cmdlet,
#then it will create the notification for all the users which satisfy if condition and the notification record will consist the deltails we have provided to its attributes.

function Set-Notification {


#Retrieve all users of Pimco Dynamics Crm365.
$contacts = Get-CrmRecords -conn $conn -EntityLogicalName systemuser -Fields systemuserid,domainname,isdisabled,islicensed -TopCount 10
       
    

#Create Perform Release notifaction for each user satisfying required conditions.
for($i = 0; $i -lt $contacts.Values.systemuserid.length; $i++) {

if(($contacts.Values.isdisabled[$i] -eq "Enabled")){
      

try{

$
$lookupObject = New-Object -TypeName Microsoft.Xrm.Sdk.EntityReference;

$lookupObject.LogicalName = "systemuser";

$lookupObject.Id = $contacts.Values.systemuserid[$i];

$notificationId = New-CrmRecord -conn $conn -EntityLogicalName appnotification -Fields @{"title"="test11";"body"="Check out the latest updates on new features and bug fixes"; "ownerid"=[Microsoft.Xrm.Sdk.EntityReference] $lookupObject} 

# Display the Guid 
$notificationid 
}

catch{"An Error Occured"}

}
}
}




function Call-Action {
    try{
        Invoke-CrmAction -Name "msdyn_DeleteFlow" 
        }
    catch [System.IO.IOEXCEPTION]{"error"}

<#
.SYNOPSIS

function - Call-Action will trigger a crm Action.

.DESCRIPTION
        
This function have a required parameter -Name, with this name it will call the respective crm Action.

.INPUTS
        
-Name = Unique name of crm Action.

.OUTPUTS
        
Action Trigerred.

#>

}




