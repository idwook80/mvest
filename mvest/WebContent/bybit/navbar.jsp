<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-md bg-dark navbar-dark">
  <a class="navbar-brand" href="#">Coin Alarm Order System</a>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
   <ul class="nav navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="../index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">About</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="product-sub" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Products
                    </a>
                    <div class="dropdown-menu" aria-labelledby="product-sub">
                        <a class="dropdown-item" href="../bybit/balance.jsp">Balance</a>
                        <a class="dropdown-item" href="../bybit/orders.jsp">Order</a>
                        <a class="dropdown-item" href="#">Account</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Services
                    </a>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item" href="#">Engage</a>
                        <a class="dropdown-item" href="#">Pontificate</a>
                        <a class="dropdown-item" href="#">Synergize</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="product-sub" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                 		  Bybit
                    </a>
                    <div class="dropdown-menu" aria-labelledby="product-sub">
                        <a class="dropdown-item" href="../bybit/index.jsp">Summary</a>
                        <a class="dropdown-item" href="../bybit/orders.jsp">Orders</a>
                        <a class="dropdown-item" href="../bybit/balance.jsp">Balance</a>
                        <a class="dropdown-item" href="../bybit/balances.jsp">Balances</a>
                    </div>
                </li>
                 <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="product-sub" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                 		  Binance
                    </a>
                    <div class="dropdown-menu" aria-labelledby="product-sub">
                        <a class="dropdown-item" href="../binance/index.jsp">Summary</a>
                        <a class="dropdown-item" href="../binance/orders.jsp">Orders</a>
                        <a class="dropdown-item" href="../binance/balance.jsp">Balance</a>
                        <a class="dropdown-item" href="../binance/balances.jsp">Balances</a>
                    </div>
                </li>
            </ul>
  </div>  
	 <!--  <form class="form-inline" action="/action_page.php">
	  
	  	<div class="input-group ">
		  <input type="text" class="form-control" placeholder="Search">
		  <div class="input-group-append">
		    <button class="btn btn-success" type="submit">Go</button>
		  </div>
		</div>
	  </form> -->
 		<!--  <button class="navbar-toggler" style="float: right;"type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		    <span class="navbar-toggler-icon"></span>
		  </button> -->
		  <div>
		  <button class="navbar-toggler" style="float: right;"type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		   	 <span class="navbar-toggler-icon"></span>
		  </button>
		  </div>
</nav>
<br>
