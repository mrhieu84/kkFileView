<#setting classic_compatible=true>
<link rel="icon" href="./favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
<script src="js/jquery-3.6.1.min.js" type="text/javascript"></script>
<script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/bootbox.min.js" type="text/javascript"></script>
<script>
    // Chinese environment
    var locale_zh_CN = {
        OK: 'Sure',
        CONFIRM: 'Confirm',
        CANCEL: 'Cancel'
    };
    bootbox.addLocale('locale_zh_CN', locale_zh_CN);

    /**
     * File password required
     */
    function needFilePassword() {
        if ('${needFilePassword}' == 'true') {
            let promptTitle = "You are previewing an encrypted file, please enter the file password.";
            if ('${filePasswordError}' == 'true') {
                promptTitle = "The password is wrong, please re-enter the password.";
            }
            bootbox.prompt({
                title: promptTitle,
                inputType: 'password',
                centerVertical: true,
                locale: 'locale_zh_CN',
                callback: function (filePassword) {
                    if (filePassword != null) {
                        const locationHref = window.location.href;
                        const isInclude = locationHref.includes("filePassword=");
                        let redirectUrl = null;
                        if (isInclude) {
                            const url = new URL(locationHref);
                            url.searchParams.set("filePassword", filePassword);
                            redirectUrl = url.href;
                        } else {
                            redirectUrl = locationHref + '&filePassword=' + filePassword;
                        }
                        window.location.replace(redirectUrl);
                    } else {
                        location.reload();
                    }
                }
            });
        }
    }
</script>

<style>
    * {
        margin: 0;
        padding: 0;
    }

    html, body {
        height: 100%;
        width: 100%;
    }
</style>

