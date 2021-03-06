<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Insert title here</title>
                <link rel="stylesheet" type="text/css"
                    href="${ pageContext.request.contextPath }/resources/css/openMyPage.css">
                <link rel="stylesheet" href="my.css">
                <link rel="stylesheet" type="text/css"
                    href="${ pageContext.request.contextPath }/resources/css/font-awesome.min.css">
                <link rel="stylesheet" href="my.css">
                <link rel="preconnect" href="https://fonts.googleapis.com">

                <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css"
                    integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw=="
                    crossorigin="anonymous" referrerpolicy="no-referrer" />

                <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500;700&display=swap"
                    rel="stylesheet">
                <script type="text/javascript"
                    src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
                <script src="https://code.jquery.com/jquery-3.6.0.slim.js"
                    integrity="sha256-HwWONEZrpuoh951cQD1ov2HUK5zA5DwJ1DNUXaM6FsY=" crossorigin="anonymous"></script>
                <script src="https://kit.fontawesome.com/4c1ea28292.js" crossorigin="anonymous"></script>


                <script>


                    $(document).ready(function (e) {
                        mergeRowspan("orderdel");
                        mergeRowspan("orderstate");

                    });


                    function mergeRowspan(className) {
                        $("." + className).each(function () {
                            var rows = $("." + className + ":contains('" + $(this).text() + "')");
                            if (rows.length > 1) {
                                rows.eq(0).attr("rowspan", rows.length);
                                rows.not(":eq(0)").remove();
                            }
                        });
                    }




                    $(document).ready(function () {
                        /* ?????? ??????????????? ????????? */
                        setTotalInfo();



                    });

                    function setTotalInfo() {

                        let totalPrice = 0;				// ??? ??????
                        let totalCount = 0;				// ??? ??????
                        let totalKind = 0;				// ??? ??????
                        let totalPoint = 0;				// ??? ????????????
                        let saleprice = 0;				// ????????????
                        let finalTotalPrice = 0; 		// ?????? ??????(??? ?????? + ?????????)	
                        let saletotalres = 0; 		// ?????? ?????? ??????
                        let booksprice = 0; 		// ?????? ?????? ??????


                        $(".cart_info").each(function (index, element) {

                            totalPrice += parseInt($(element).find(".totalPrice").val());
                            saleprice += parseInt($(element).find(".saleprice").val());

                            //?????????
                            booksprice += parseInt($(element).find(".bookprice").val());
                            console.log(booksprice + "?????????");

                            console.log(totalPrice);

                            /* ??? ?????? */
                            totalCount = document.getElementsByClassName('tr_back').length;
                            // ??? ??????
                            totalKind += 1;

                        })

                        usepoint = parseInt($(".usepoint").text());

                        console.log(usepoint);

                        saletotalres = usepoint + saleprice



                        totalPrice + ${ order.deliveryCost };

                        $(".firstorder").text(totalPrice.toLocaleString());


                        //?????????
                        $(".bookspricespan").text(booksprice.toLocaleString());


                        $(".discountres").text(saletotalres.toLocaleString());

                        // ??? ??????
                        $(".totalCount_span").text(totalCount);

                        // ??? ??????
                        $(".totalKind_span").text(totalKind);

                        $(".salepriceres").text(saleprice);

                    }




                    function payback(num) {


                        if (!confirm("?????? ???????????????????")) {
                            return;
                        }
                        // //???????????? -- ?????? ????????? ???????????? ?????? 
                        // // ?????? ????????? ??????
                        // //?????? ?????? ??? ?????????????????? ??????


                        var url = "refund.do";
                        var param = "orderId=" + num;
                        sendRequest(url, param, delOneResult, "POST");
                    }

                    function delOneResult() {
                        if (xhr.readyState == 4 && xhr.status == 200) {
                            var data = xhr.responseText;
                            if (data == 'true') {
                                alert('?????????????????????.');

                            } else {
                                alert('?????? ??????, ??????????????? ???????????????');
                            }
                            opener.parent.location.reload();
                            window.location.reload();
                        }
                    }

                    function okay() {
                        window.close();
                    }





                </script>

            </head>

            <body>
                <div class="view">
                    <span>????????????????????????</span>
                </div>

                <section>

                    <div class="list" style="    font-size: 29px;
                margin-bottom: 15px;
            ">
                        <span class="orderlistfont">??????????????????</span>
                        <span style="    color: red;" class="totalKind_span">0</span>???
                        <span style="    color: red;" class="totalCount_span">0</span>???
                    </div>
                    <div class="orderhead">
                        <div style="    margin-right: 9%;">
                            <span style="    margin-right: 10px;">????????????</span>
                            <span>${order.orderDate}</span>
                        </div>
                        <div>
                            <span style="    margin-right: 10px;">????????????</span>
                            <span class="orderId">${order.orderId}</span>
                        </div>
                    </div>
                    <div>

                        <div style="    margin-top: 9px; 
            ">
                            <span class="delinfo"> ????????? ??????</span>
                            <div class="delivery_info">
                                <div class="delname">
                                    <span>?????????</span>
                                    <span>??????</span>
                                    <span style="width: 70px;">?????? ??????</span>
                                    <span style="    width: 102px;">????????? ?????????</span>
                                </div>
                                <div class="delresult">
                                    <span>${order.addressee}</span>
                                    <span>(${order.memberAddr1}) ${order.memberAddr2} ${order.memberAddr3}</span>
                                    <span>${order.orderDate}</span>
                                    <span>${order.deliverytel1} ${order.deliverytel2} ${order.deliverytel3}</span>
                                </div>
                            </div>
                        </div>
                        <div style="    width: 100%;">
                            <div class="orderlistfonts" style="    margin-top: 9px;">
                                ?????? ??????
                            </div>
                            <div class=orderdiv>
                                <table border="1px">
                                    <tr>
                                        <td style="padding-right: 168px;">????????????</td>
                                        <td style="    padding-right: 0px; text-align: center; padding-left: 0;
        
                                           ">?????????</td>
                                        <td style="    padding-right: 0px;
                                               text-align: center;
                                        padding-left: 0;">????????????</td>
                                    </tr>
                                    <c:forEach var="vo" items="${item}" varStatus="status">
                                        <div class="cart_info">
                                            <div style="display: none;">
                                                <input type="hidden" class="saleprice"
                                                    value="${vo.bookcnt * (vo.price * 0.1)}"><br>
                                                <input type="hidden" class="totalPrice"
                                                    value="${vo.bookcnt * vo.price + order.deliveryCost}"><br>
                                                <input type="hidden" class="bookprice" value="${vo.price}"><br>
                                            </div>
                                            <tr class="tr_back">
                                                <td>
                                                    <span>${vo.booknum}</span>
                                                    <span> ${vo.subject}</span>
                                                    <span class="prices"> ${vo.price}</span>
                                                    <span> ${vo.author}</span>
                                                    <span> ${vo.bookcnt}</span>
                                                    <span> ${vo.publisher}</span>
                                                    <span>
                                                        <fmt:formatDate pattern="yyyy-MM-dd"
                                                            value="${vo.publishdate}" />
                                                    </span>

                                                </td>
                                        </div>
                                        <td class="orderdel" style="text-align: center;">
                                            ${order.deliveryCost}</td>
                                        <td class="orderstate" style="text-align: center;">
                                            ${order.orderState}</td>
                                        </tr>
                                    </c:forEach>

                                </table>
                            </div>
                        </div>
                    </div>

                    <div style="
                    margin-top: 13px;">
                        <span class="deldetailfonts">?????? ?????? ??????</span>
                        <div>
                            <div style="    display: flex;
                            width: 100%;
                            justify-content: space-evenly">
                                <div class="deldetailinfo">
                                    <div class="orders">
                                        <span class="orderpayfont">????????????</span>
                                        <span class="under" style="    margin-top: 4px;">??? ????????????</span>
                                        <span class="under" style="    margin-top: 4px;">??? ?????????</span>
                                    </div>
                                    <div class="results">
                                        <span class="firstorder">???</span>
                                        <span style="
                                    margin-top: 4px;" class="bookspricespan"></span>
                                        <span style="
                                    margin-top: 4px;">${order.deliveryCost}</span>
                                    </div>
                                </div>

                                <div style="    display: flex;
                                align-items: center;">
                                    <span style="    font-size: 31px;
                                color: #456BD8;">
                                        <i class="fa fa-minus-circle" aria-hidden="true"></i>
                                    </span>
                                </div>

                                <div class="point_pay">
                                    <div class="pay_one">
                                        <span class="orderpayfonts">????????????</span>
                                        <span class="under" style="display: flex;
                                flex-direction: column;">??? ?????????</span>
                                        <span class="under">??? ?????? ??????</span>
                                    </div>


                                    <div style="    display: flex;
                            flex-direction: column;">
                                        <span class="discountres"></span>
                                        <span class="usepoint">${order.usePoint}</span>
                                        <span class="salepriceres"></span>
                                    </div>
                                </div>
                            </div>
                            <div style="    text-align: center;
                            margin-top: 20px;">

                                <div>
                                    <span>?????? ?????????</span>
                                    <span> ${order.savePoint}???</span>
                                </div>
                                <div>
                                    <span class="totalfonts">??? ????????????
                                    </span>
                                    <span class="fontres">
                                        ${order.orderFinalSalePrice} ???
                                    </span>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </section>
                <footer>
                    <div class="foot">
                        <div onclick="okay()">??????</div>

                        <c:if test="${order.orderState eq '????????????' || order.orderState eq '????????????'}">
                            <div id="refund_click" onclick="payback('${order.orderId}')">????????????</div>
                        </c:if>


                    </div>

                </footer>


            </body>

            </html>