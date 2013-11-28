
function getRadioCheckedValue(radio_name)
{
    var oRadio = document.forms[0].elements[radio_name];
    for(var i = 0; i < oRadio.length; i++)
    {
        if(oRadio[i].checked)
        {
            return oRadio[i].value;
        }
    }
    return '';
}
