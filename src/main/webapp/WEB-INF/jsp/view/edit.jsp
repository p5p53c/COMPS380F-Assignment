<!DOCTYPE html>
<html>

    <head>
        <title>Online Course Website</title>
        <style>
            .drop-zone {
                max-width: 200px;
                height: 200px;
                padding: 25px;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
                font-family: "Quicksand", sans-serif;
                font-weight: 500;
                font-size: 20px;
                cursor: pointer;
                color: #cccccc;
                border: 4px dashed #009578;
                border-radius: 10px;
            }

            .drop-zone--over {
                border-style: solid;
            }

            .drop-zone__input {
                display: none;
            }

            .drop-zone__thumb {
                width: 100%;
                height: 100%;
                border-radius: 10px;
                overflow: hidden;
                background-color: #cccccc;
                background-size: cover;
                position: relative;
            }

            .drop-zone__thumb::after {
                content: attr(data-label);
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100%;
                padding: 5px 0;
                color: #ffffff;
                background: rgba(0, 0, 0, 0.75);
                font-size: 14px;
                text-align: center;
            }
        </style>
    </head>

    <body onLoad="init()">
        <c:url var="logoutUrl" value="/cslogout" />
        <form action="${logoutUrl}" method="post">
            <input id="t_logout" type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            [<a href="#" onclick="trans(this.innerHTML)">English</a>
            |<a href="#" onclick="trans(this.innerHTML)">中文</a>]
        </form>

        <h2><span id="t_material">Material</span> #${material.id}</h2>
        <form:form method="POST" enctype="multipart/form-data" modelAttribute="materialForm">
            <form:label id="t_materialname" path="materialname">Material Name</form:label><br />
            <form:input type="text" path="materialname" /><br /><br />
            <form:label id="t_materialbody" path="materialbody">Body</form:label><br />
            <form:textarea path="materialbody" rows="5" cols="30" /><br /><br />
            <c:if test="${fn:length(material.attachments) > 0}">
                <b id="t_attachments">Attachments:</b><br />
                <ul>
                    <c:forEach items="${material.attachments}" var="attachment">
                        <li>
                            <c:out value="${attachment.name}" />
                            [<a href="<c:url
                                    value="/material/${material.id}/delete/${attachment.name}" />">Delete</a>]
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
            <b id="t_addattachments">Add attachments</b><br />
            <!-- <input type="file" name="attachments" multiple="multiple" /><br /><br /> -->

            <div class="drop-zone">
                <span class="drop-zone__prompt">Drop file here or click to upload</span>
                <input type="file" name="attachments" class="drop-zone__input" multiple="multiple">
            </div>
            <br/>
            <input id="t_submit" type="submit" value="Save" /> <input id="t_back" type=button value="Back" onCLick="javascript:history.go(-1)">
        </form:form>

        <script>
            document.querySelectorAll(".drop-zone__input").forEach((inputElement) => {
                const dropZoneElement = inputElement.closest(".drop-zone");

                dropZoneElement.addEventListener("click", (e) => {
                    inputElement.click();
                });

                inputElement.addEventListener("change", (e) => {
                    if (inputElement.files.length) {
                        updateThumbnail(dropZoneElement, inputElement.files);
                    }
                });

                dropZoneElement.addEventListener("dragover", (e) => {
                    e.preventDefault();
                    dropZoneElement.classList.add("drop-zone--over");
                });

                ["dragleave", "dragend"].forEach((type) => {
                    dropZoneElement.addEventListener(type, (e) => {
                        dropZoneElement.classList.remove("drop-zone--over");
                    });
                });

                dropZoneElement.addEventListener("drop", (e) => {
                    e.preventDefault();

                    if (e.dataTransfer.files.length) {
                        inputElement.files = e.dataTransfer.files;
                        updateThumbnail(dropZoneElement, e.dataTransfer.files);
                    }

                    dropZoneElement.classList.remove("drop-zone--over");
                });
            });

            function updateThumbnail(dropZoneElement, files) {
                let thumbnailElement = dropZoneElement.querySelector(".drop-zone__thumb");

                // First time - remove the prompt
                if (dropZoneElement.querySelector(".drop-zone__prompt")) {
                    dropZoneElement.querySelector(".drop-zone__prompt").remove();
                }

                // First time - there is no thumbnail element, so lets create it
                if (!thumbnailElement) {
                    thumbnailElement = document.createElement("div");
                    thumbnailElement.classList.add("drop-zone__thumb");
                    dropZoneElement.appendChild(thumbnailElement);
                }

                if (files.length > 1) {
                    let temp = files[0].name;
                    for (let i = 1; i < files.length; i++) {
                        temp += ", ";
                        temp += files[i].name;
                    }
                    thumbnailElement.dataset.label = temp;
                } else
                    thumbnailElement.dataset.label = files[0].name;

                // Show thumbnail for image files
                if (files[0].type.startsWith("image/")) {
                    const reader = new FileReader();

                    reader.readAsDataURL(files[0]);
                    reader.onload = () => {
                        thumbnailElement.style.backgroundImage = `url('${reader.result}')`;
                    };
                } else {
                    thumbnailElement.style.backgroundImage = null;
                }
            }

            const localStorage = window.localStorage;
            function init() {
                if (localStorage) {
                    trans(localStorage.getItem("language"));
                }
            }
            const trans = (language) => {
                switch (language) {
                    case "English":
                        document.getElementById("t_logout").value = "Log out";
                        document.getElementById("t_material").innerHTML = "Material";
                        document.getElementById("t_materialname").innerHTML = "Material Name";
                        document.getElementById("t_materialbody").innerHTML = "Body";
                        if (document.getElementById("t_attachments"))
                            document.getElementById("t_attachments").innerHTML = "Attachments:";
                        document.getElementById("t_addattachments").innerHTML = "Add attachments";
                        document.getElementsByClassName("drop-zone__prompt")[0].innerHTML = "Drop file here or click to upload";
                        document.getElementById("t_submit").value = "Save";
                        document.getElementById("t_back").value = "Back";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        document.getElementById("t_logout").value = "登出";
                        document.getElementById("t_material").innerHTML = "講義";
                        document.getElementById("t_materialname").innerHTML = "講義名稱";
                        document.getElementById("t_materialbody").innerHTML = "內容";
                        if (document.getElementById("t_attachments"))
                            document.getElementById("t_attachments").innerHTML = "附件：";
                        document.getElementById("t_addattachments").innerHTML = "加入附件";
                        document.getElementsByClassName("drop-zone__prompt")[0].innerHTML = "拖拉檔案到此處上載";
                        document.getElementById("t_submit").value = "儲存";
                        document.getElementById("t_back").value = "返回";
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>

</html>