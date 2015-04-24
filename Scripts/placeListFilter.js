/*java script and JQuery functions to accomodate Places list filter from a text box */
        
    $(document).ready(function () {
        $("#<%=lbxFrom.ClientID%>").hide();
        $("#<%=lbxTo.ClientID%>").hide();

        $("#<%=txtFrom.ClientID%>").focusin(function () {
            $("#<%=lbxTo.ClientID%>").fadeOut();
            $("#<%=lbxFrom.ClientID%>").fadeIn();
        });

        $("#<%=txtFrom.ClientID%>").focusout(function () {
            $("#<%=lbxFrom.ClientID%>").fadeOut();
        });

        $("#<%=txtTo.ClientID%>").focusin(function () {
            $("#<%=lbxTo.ClientID%>").toggleClass("hidden", false);
            $("#<%=lbxTo.ClientID%>").fadeIn();
        });

        $("#<%=txtTo.ClientID%>").focusout(function () {
            $("#<%=lbxTo.ClientID%>").fadeOut();
        });
    });

function updateToText() {
    $("#<%=txtTo.ClientID%>").val($("#<%=lbxTo.ClientID%> option:selected").text());
    $("#<%=lbxTo.ClientID%>").fadeOut();
            
}

function updateFromText() {
    $("#<%=txtTo.ClientID%>").val("");
    $("#<%=btnToHIdden.ClientID%>").trigger('click');
    $("#<%=txtFrom.ClientID%>").val($("#<%=lbxFrom.ClientID%> option:selected").text());
    $("#<%=lbxFrom.ClientID%>").fadeOut();
    $("#<%=lbxTo.ClientID%>").toggleClass("hidden", true);

}

function refreshFromList()
{
    var pretext = $("#<%=txtFrom.ClientID%>").val();

    if (pretext.length > 2 || pretext.length == 0)
        $("#<%=btnFrmHidden.ClientID%>").trigger('click');
}
function refreshToList(textID, buttonID) {
            
    var pretext = $("#<%=txtTo.ClientID%>").val();
    if (pretext.length > 2 || pretext.length == 0) {
        $("#<%=btnToHIdden.ClientID%>").trigger('click');
    }
}