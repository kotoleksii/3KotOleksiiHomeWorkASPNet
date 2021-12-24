<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="_3KotOleksiiHomeWorkASPNet.Products" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
        rel="stylesheet" 
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
        crossorigin="anonymous"/>
    <link href="/css/product.css" rel="stylesheet" />
</head>
<body class="bg-dark">
    <form id="frmViewProducts" runat="server">
        <asp:SqlDataSource ID="dsProducts"
            runat="server"
            ConnectionString='<%$ ConnectionStrings:StorageDB %>'
            SelectCommand="SELECT * FROM [Products]"
            DeleteCommand="DELETE FROM [Products] WHERE [ID] = @ID"
            InsertCommand ="INSERT INTO Products(Title, Description, Count, Price) VALUES (@Title, @Description, @Count, @Price)"
            UpdateCommand="UPDATE [Products] SET [Title] = @Title, [Description] = @Description, [Count] = @Count, [Price] = @Price WHERE [ID] = @ID" 
            >
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Title" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="Count" Type="Int32" />
                <asp:Parameter Name="Price" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Title" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="Count" Type="Int32" />
                <asp:Parameter Name="Price" Type="Int32" />
                <asp:Parameter Name="ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <div class="container my-3 pb-4">
            <div class="text-center text-white pb-3">
                <h1>Product Management</h1>
            </div>
            <div class="row">
                <div class="col-md-8 pt-3 me-5">
                    <div class="mb-2">
                        <asp:Repeater ID="repeaterProducts" runat="server" DataSourceID="dsProducts" OnItemCommand="repeaterProducts_ItemCommand">
                            <HeaderTemplate>
                                <table class="table table-dark table-striped text-center">
                                    <thead>
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Title</th>
                                            <th scope="col">Description</th>
                                            <th scope="col">Count</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Actions</th>
                                        </tr>
                                    </thead>
                                <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <th scope="row"><%# Eval("ID") %></th>
                                    <td><%# Eval("Title") %></td>
                                    <td><%# Eval("Description") %></td>
                                    <td><%# Eval("Count") %></td>
                                    <td><%# Eval("Price") %></td>
                                    <td>                     
                                    <asp:LinkButton runat="server" 
                                        CommandArgument='<%# Eval("ID") %>'
                                        CommandName="editProduct" ID="imgBtnEdit" CssClass="btn btn-outline-warning">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                                            <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
                                            </svg>
                                    </asp:LinkButton>
                                    <asp:LinkButton runat="server" 
                                        CommandArgument='<%# Eval("ID") %>'
                                        CommandName="deleteProduct" ID="imgBtnDelete" CssClass="btn btn-outline-danger"
                                        OnClientClick="return AlertFunction();">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                            <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                            </svg>
                                    </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="col-md-3 pt-3">
                    <div class="card text-white bg-dark">
                        <div class="card-header text-center">
                            <asp:Label ID="lblCardTitle" runat="server" Text="Add"></asp:Label> 
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label for="txtTitle">Title</label>
                                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control text-center bg-secondary border-0"></asp:TextBox>                         
                                <asp:RequiredFieldValidator 
                                    ID="validateRequiredTitle"
                                    runat="server" 
                                    ErrorMessage="* заповніть Title" 
                                    Display="None"
                                    ControlToValidate="txtTitle"
                                    EnableClientScript="False">
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="mb-3">
                                <label for="txtDescription">Description</label>
                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control text-center bg-secondary border-0"></asp:TextBox>                                
                            </div>
                             <div class="mb-3">
                                 <label for="txtCount">Count</label>
                                <asp:TextBox ID="txtCount" type="number" runat="server" CssClass="form-control text-center bg-secondary border-0" ></asp:TextBox>
                                <asp:RequiredFieldValidator 
                                    ID="validateRequiredCount"
                                    runat="server"
                                    ErrorMessage="* заповніть Count"
                                    Display="None"
                                    ControlToValidate="txtCount"
                                    EnableClientScript="False">
                                </asp:RequiredFieldValidator>
                             </div>
                             <div class="mb-3">
                                 <label for="txtPrice">Price</label>
                                <asp:TextBox ID="txtPrice" type="number" runat="server" CssClass="form-control text-center bg-secondary border-0"></asp:TextBox>
                                 <asp:RequiredFieldValidator 
                                        ID="validateRequiredPrice"
                                        runat="server"
                                        ErrorMessage="* заповніть Price"
                                        Display="None"
                                        ControlToValidate="txtPrice"
                                        EnableClientScript="False">
                                    </asp:RequiredFieldValidator>
                             </div>
                            <div class="mb-0">
                                <asp:ValidationSummary ID="validateAllFields" runat="server" CssClass="text-danger" />       
                            </div>
                        </div>
                        <div class="card-footer mt-0">
                            <div class="mb-0">
                                <asp:Button ID="btnAddProduct" runat="server" OnClick="btnAddProduct_Click"
                                   Text="Add" CssClass="btn btn-outline-success w-100"/>
                                <asp:Button ID="btnEditProduct" runat="server" OnClick="btnEditProduct_Click"
                                    Text="Edit" CssClass="btn btn-outline-warning w-100" Visible="false"/>
                            </div>  
                        </div>
                    </div>  
                </div>
            </div>
        </div>
    </form>         
</body>
     <script>     
        function AlertFunction() {
            if (confirm('Are you sure you want to delete this entry in the database?')) {
                return;
            } else {
                return false;
            }
        }
     </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" 
        crossorigin="anonymous"></script>
</html>
