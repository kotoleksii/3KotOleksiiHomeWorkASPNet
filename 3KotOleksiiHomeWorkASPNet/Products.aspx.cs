using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using _3KotOleksiiHomeWorkASPNet.Models;

namespace _3KotOleksiiHomeWorkASPNet
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void repeaterProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productID = 0;

            int.TryParse(e.CommandArgument.ToString(), out productID);

            if (productID > 0)
            {
                switch (e.CommandName)
                {
                    case "deleteProduct":
                        deleteProduct(productID);
                        break;
                    case "editProduct":
                        {
                            ProductViewModel productToEdit = getProductByID(productID);
                            editProduct(productToEdit);

                            SetEditProductID(productID);
                            restoreDataSourceSelectCommand();

                            break;
                        }
                }
            }
        }

        private void restoreDataSourceSelectCommand()
        {
            dsProducts.SelectCommand = $"SELECT * FROM [Products]";
            dsProducts.SelectParameters.Clear();
        }

        private void SetEditProductID(int productID)
        {
            Session["EditProductID"] = productID;
        }

        private void editProduct(ProductViewModel productToEdit)
        {

        }

        private ProductViewModel getProductByID(int productID)
        {
            ProductViewModel productToEdit = null;
            dsProducts.SelectCommand = $"SELECT Title, Description, Count, Price FROM [Products] WHERE [ID] = @ID";
            dsProducts.SelectParameters.Add(
                        new Parameter(
                            "UserID",
                        System.Data.DbType.Int32,
                    productID.ToString()
                )
            );

            try
            {
                var productDataRows = dsProducts.Select(DataSourceSelectArguments.Empty);

                if (productDataRows != null)
                {
                    foreach (var dataRow in productDataRows)
                    {
                        object[] curProductData = (dataRow as DataRowView).Row.ItemArray;

                        productToEdit = parseProductFromDbRow(curProductData);
                    }
                }
            }
            catch
            { }
            return productToEdit;
        }

        private void deleteProduct(int productID)
        {

        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {

        }

        protected void btnEditProduct_Click(object sender, EventArgs e)
        {

        }

        private ProductViewModel parseProductFromDbRow(object[] curProductData)
        {
            ProductViewModel productFromDb = new ProductViewModel();

            productFromDb.Title = curProductData[0].ToString();
            productFromDb.Description = curProductData[1].ToString();
            productFromDb.Count = (int)curProductData[2];
            productFromDb.Price = (int)curProductData[3];

            return productFromDb;
        }
    }
}