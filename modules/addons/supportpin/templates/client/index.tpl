<!--
* WHMCS-SupportPIN - Let your customers generate a support/phone pin to identify your customers faster, for example on the phone
*
* Copyright (c) 2021 Felix Brettnich
*
* This file is part of fbrettnich/whmcs-supportpin-module
*
* Licensed under GPL-3.0 (https://github.com/fbrettnich/whmcs-supportpin-module/blob/main/LICENSE)
-->
<style>
    .icon-rotate {
        animation: fas-spin 2s infinite linear;
    }
    @-webkit-keyframes fas-spin{0%{-webkit-transform:rotate(0deg);transform:rotate(0deg)}100%{-webkit-transform:rotate(359deg);transform:rotate(359deg)}}
    @keyframes fas-spin{0%{-webkit-transform:rotate(0deg);transform:rotate(0deg)}100%{-webkit-transform:rotate(359deg);transform:rotate(359deg)}}
</style>

<div style="text-align: center;">
    <div style="font-size: 35px; margin: 50px;">{$lang_client_title}</div>

    <div id="sPIN" style="font-size: 55px; color: Black; margin: 50px;">{$tplVars.supportpin}</div>

    <p>{$lang_client_info}</p>

    <a href="#" onclick="RenewPIN()" class="btn btn-success" style="width: 50%; margin: 50px;"><i class="fas fa-sync-alt icon-rotate" id="pinIcon"></i> {$lang_client_regenerate}</a>
</div>



<script>
    var isLoading = false;
    
    function Request(url, callback, errorCallback = false) {
        $.ajax({
            type: "POST",
            crossDomain: false,
            url: url,
            data: { "PIN": true },
            success: function (respond) {
                callback(respond);
            },
            error: function (response) {
                if (!errorCallback) {
                    console.log(response.status);
                    return;
                }
                errorCallback(response);
            }
        });
    };
    
    function RenewPIN() {
        if (isLoading) return;
        isLoading = true;
        $('#pinIcon').addClass('icon-rotate');
        Request("index.php?m=supportpin&page=renew", function (response) {
            $("#sPIN").html(response.PIN);
            $('#pinIcon').removeClass('icon-rotate');
            isLoading = false;
        }, function (reponse) {
            isLoading = false;
            $('#pinIcon').removeClass('icon-rotate');
        });
    }
</script>