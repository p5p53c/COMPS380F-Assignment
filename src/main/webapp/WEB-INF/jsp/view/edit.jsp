<!DOCTYPE html>
<html>

<head>
    <title>Customer Support</title>
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

<body>
    <c:url var="logoutUrl" value="/cslogout" />
    <form action="${logoutUrl}" method="post">
        <input type="submit" value="Log out" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>

    <h2>Material #${material.id}</h2>
    <form:form method="POST" enctype="multipart/form-data" modelAttribute="materialForm">
        <form:label path="materialname">Material Name</form:label><br />
        <form:input type="text" path="materialname" /><br /><br />
        <form:label path="materialbody">Body</form:label><br />
        <form:textarea path="materialbody" rows="5" cols="30" /><br /><br />
        <c:if test="${fn:length(material.attachments) > 0}">
            <b>Attachments:</b><br />
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
        <b>Add attachments</b><br />
        <!-- <input type="file" name="attachments" multiple="multiple" /><br /><br /> -->

        <div class="drop-zone">
            <span class="drop-zone__prompt">Drop file here or click to upload</span>
            <input type="file" name="attachments" class="drop-zone__input" multiple="multiple">
        </div>

        <input type="submit" value="Save" /> <input type=button value="Back" onCLick="history.back()">
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
            }
            else
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

    </script>
</body>

</html>