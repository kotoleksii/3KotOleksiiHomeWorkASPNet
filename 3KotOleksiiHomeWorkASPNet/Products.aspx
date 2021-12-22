<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="_3KotOleksiiHomeWorkASPNet.Products" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="frmViewProducts" runat="server">
        <asp:SqlDataSource ID="dsProducts"
            runat="server"
            ConnectionString='<%$ ConnectionStrings:StorageDB %>'
            SelectCommand="SELECT * FROM [Products]"
            DeleteCommand="DELETE FROM [Products] WHERE [ID] = @ID"
            InsertCommand ="INSERT INTO Products(Title, Description, Count, Price) VALUES (@Title, @Description, @Count, @Price)"
            UpdateCommand="UPDATE [Products] SET [Title] = @Title, [Description] = @Description, [Count] = @Count, [Price] = @Price WHERE [ID] = @ID" ProviderName="<%$ ConnectionStrings:StorageDB.ProviderName %>"
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
        <div>
            <asp:Repeater ID="repeaterProducts" runat="server" DataSourceID="dsProducts" OnItemCommand="repeaterProducts_ItemCommand">
            <HeaderTemplate>
                <table>
                    <thead>
                        <tr>
                            <td>ID</td>
                            <td>Title</td>
                            <td>Description</td>
                            <td>Count</td>
                            <td>Price</td>
                            <td>Actions</td>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("ID") %></td>
                    <td><%# Eval("Title") %></td>
                    <td><%# Eval("Description") %></td>
                    <td><%# Eval("Count") %></td>
                    <td><%# Eval("Price") %></td>
                    <td>
                        <asp:ImageButton ID="imgBtnDelete"
                            runat="server"
                            CommandArgument='<%# Eval("ID") %>'
                            CommandName="deleteProduct"
                            ImageUrl="~/img/delete.png"
                            />
                        <asp:ImageButton ID="imgBtnEdit"
                            runat="server"
                            CommandName="editProduct"
                            CommandArgument='<%# Eval("ID") %>'
                            ImageUrl="~/img/edit.png"
                            />
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
                </table>
            </FooterTemplate>
            </asp:Repeater>
        </div>
        <div>
            <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Count</th>
                    <th>Price</th>
                </tr>
                 </thead> 
                <tr>
                    <td><asp:TextBox ID="txtTitle" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtDescription" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtCount" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtPrice" runat="server"></asp:TextBox></td>
                </tr> 
            <tr>
                <td></td>
                <td></td>
                <td>
                    <asp:Button ID="btnAddProduct" runat="server" OnClick="btnAddProduct_Click"
                        Text="Add Product"/>
                    <asp:Button ID="btnEditProduct" runat="server" OnClick="btnEditProduct_Click"
                        Text="Edit Product" Visible="false"/>
                </td>
            </tr>
        </table>
        </div>
    </form>
</body>
</html>
