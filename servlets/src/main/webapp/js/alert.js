function notificationALert(message, type, timeOfShow = 2) {
  if (type === null || type === undefined) {
    type = "info";
  }


  // Create notification div
  var notificationDiv = document.createElement("div");
  notificationDiv.classList.add("notification");
  notificationDiv.id = "notification";

  // Create alert div
  var alertDiv = document.createElement("div");
  alertDiv.classList.add(
    "alert",
    "alert-dismissible",
    "fade",
    "show"
  );
  alertDiv.setAttribute("role", "alert");

  

  // Create notification text
  var notificationText = document.createTextNode(message);

  // Create close button
  var closeButton = document.createElement("button");
  closeButton.setAttribute("type", "button");
  closeButton.classList.add("close");
  closeButton.setAttribute("data-dismiss", "alert");
  closeButton.setAttribute("aria-label", "Close");
  // to remove notification
  closeButton.setAttribute('onclick', 'this.parentElement.parentElement.remove();');

  var closeIcon = document.createElement("span");
  closeIcon.setAttribute("aria-hidden", "true");
  closeIcon.innerHTML = "&times;";

  var icon = document.createElement("i");
  
  // set the icon and the color of the notification
  switch (type) {
    case "success":
      alertDiv.classList.add("alert-success");
      icon.classList.add("bi", "bi-check-circle");
      break;
    case "danger":
      alertDiv.classList.add("alert-danger");
      icon.classList.add("bi", "bi-exclamation-triangle");
      break;
    case "secondary":
      alertDiv.classList.add("alert-secondary");
      break;
    case "default":
      alertDiv.classList.add("alert-primary");
      icon.classList.add("bi", "bi-info-circle");
      break;
  }

  


  // append all the elements
  closeButton.appendChild(closeIcon);
  alertDiv.appendChild(icon);
  alertDiv.appendChild(notificationText);
  alertDiv.appendChild(closeButton);
  notificationDiv.appendChild(alertDiv);
  document.body.appendChild(notificationDiv);

  // Remove the notification after the specified delay time
  setTimeout(function () {
    notificationDiv.remove();
  }, timeOfShow*1000);
}


window.addEventListener("load", addCustumCSS);

// add the css to the head of the html file
function addCustumCSS(){
  var head = document.head;
  var link = document.createElement("link");

  link.type = "text/css";
  link.rel = "stylesheet";
  link.href = "css/notification.css";

  head.appendChild(link);
}
