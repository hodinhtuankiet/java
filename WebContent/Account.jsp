<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html lang="en">

<head>
  <title>Account</title>
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

    <link rel="stylesheet" href="css/admin.css" />
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<body style="background:url(./assets/img/hotel.jpg);background-size: cover;background-repeat: no-repeat;">
  <div class="container">
    <nav>
      <div class="navbar">
        <div class="logo">
		<img src="./css/Rectangle58.jpg" alt="">
          <h1>Admin</h1>
        </div>
        <ul>
           <li><a id="active" href="list">
                            <i class="fas fa-tasks"></i>
                            <span class="nav-item">Customer</span>
                        </a>
                    </li>
                    <li><a href="account">
                            <i class="fas fa-user"></i>
                            <span class="nav-item">Account</span>
                        </a>
                    </li>
                    <li><a href="index.jsp">
                            <i class="fab fa-dochub"></i>
                            <span class="nav-item">My Website</span>
                        </a>
                    </li>
                    <li><a href="statictical.jsp">
                            <i class='bx bx-line-chart'></i>
                            <span class="nav-item">Statistical</span>
                        </a>
                    </li>
           
                    <li><a href="login.jsp" class="logout">
                            <i class="fas fa-sign-out-alt"></i>
                            <span class="nav-item">Logout</span>
                        </a>
                    </li>
        </ul>
      </div>
    </nav>

    <section class="main">
      <div class="main-top">
        <p>The K&L Coffee</p>
      </div>
      <div class="main-body">
        <h1>Recent Accounts</h1>

        <div class="search_bar">
          <input oninput="handleSearch(event)" type="search" placeholder="Search name customer here...">
        </div>
        <div class="row">
          <p style="color: white;font-weight: 600;">There are <span style="color: red" id="usersCount"></span>
            Accounts
          </p>
        </div>

        <c:forEach var="user" items="${listUser}">
        <div class="job_card">
          <div class="job_details">
            <div class="img">
              <img src="assets/img/hotel.jpg" alt="">
            </div>
            <div class="text">
              <h2><c:out value="Name: ${user.uname}" /></h2>
              <span><c:out value="Email: ${user.uemail}" /></span>
            </div>
          </div>
          <div class="job_salary">
            <h4><c:out value="Password: ${user.upassword}" /></h4>
            <span><c:out value="Contact: ${user.ucontact}" /></span>
			<a href="delete_account?id=<c:out value='${URLEncoder.encode(user.uemail, "UTF-8")}' />" class="buton-delete">Delete</a>
          </div>

          <div class="delete_form">
            <p>Do you want to delete this person??</p>
            <button class="btn-delete-confirm">Delete</button>
            <button class="btn-delete-cancel">Cancel</button>
          </div>

        </div>
         </c:forEach>
      </div>

  </div>
  </section>
  </div>
</body>
<script>
  // check bao nhieu users
  const usersCount = {{ users.length }};
  document.getElementById('usersCount').textContent = usersCount;

  const deleteButtons = document.querySelectorAll('.buton-delete');

  deleteButtons.forEach(button => {
    const userId = button.dataset.id;
    button.addEventListener('click', () => {
      const userCard = button.closest('.job_card');
      const deleteForm = userCard.querySelector('.delete_form');
      deleteForm.classList.add('active');

      //  Xóa trong form
      const btnDeleteConfirm = userCard.querySelector('.btn-delete-confirm');
      btnDeleteConfirm.addEventListener('click', () => {
        fetch(`/user/${userId}`, {
          method: 'DELETE'
        })
          .then(response => {
            if (response.ok) {
              console.log('Tài khoản đã được xóa');
              // Xóa người dùng khỏi giao diện
              userCard.remove();
            } else {
              console.error('Lỗi khi xóa tài khoản');
            }
          })
          .catch(error => {
            console.error('Lỗi khi xóa tài khoản:', error);
          });
      });

      //  Hủy  form
      const btnDeleteCancel = userCard.querySelector('.btn-delete-cancel');
      btnDeleteCancel.addEventListener('click', () => {
        deleteForm.classList.remove('active');
      });
    });
  });
</script>


</html>