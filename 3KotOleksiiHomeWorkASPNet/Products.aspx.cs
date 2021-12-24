using System;
using System.Data;
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
                        restoreDataSourceSelectCommand();
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

        private void SetEditProductID(int productID)
        {
            Session["EditProductID"] = productID.ToString();
        }

        private int GetEditProductID()
        {
            int editProductID = 0;
            int.TryParse(Session["EditProductID"].ToString(), out editProductID);

            return editProductID;
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

        private void restoreDataSourceSelectCommand()
        {
            dsProducts.SelectCommand = $"SELECT * FROM [Products]";
            dsProducts.SelectParameters.Clear();
        }

        private void editProduct(ProductViewModel productToEdit)
        {
            enableEditMode();           

            txtTitle.Text = lblCardTitle.Text = productToEdit.Title;
            txtDescription.Text = productToEdit.Description;
            txtCount.Text = productToEdit.Count.ToString();
            txtPrice.Text = productToEdit.Price.ToString();
        }

        private void enableEditMode()
        {
            btnEditProduct.Visible = true;
            btnAddProduct.Visible = false;
        }

        private void enableAddMode()
        {
            lblCardTitle.Text = "New Product";
            btnEditProduct.Visible = false;
            btnAddProduct.Visible = true;
        }

        private void cleanAddEditForm()
        {
            txtTitle.Text = "";
            txtDescription.Text = "";
            txtCount.Text = "";
            txtPrice.Text = "";
        }

        private ProductViewModel getProductByID(int productID)
        {
            ProductViewModel productToEdit = null;
            dsProducts.SelectCommand = $"SELECT Title, Description, Count, Price FROM [Products] WHERE [ID] = @ID";
            dsProducts.SelectParameters.Add(
                        new Parameter(
                            "ID",
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
            dsProducts.DeleteParameters["ID"].DefaultValue = productID.ToString();

            try
            {
                dsProducts.Delete();
            }
            catch
            {
            }
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            if (txtTitle.Text != "" && txtCount.Text != "" && txtPrice.Text != "")  
            {
                ProductViewModel newProduct = new ProductViewModel()
                {
                    Title = txtTitle.Text,
                    Description = txtDescription.Text,
                    Count = int.Parse(txtCount.Text),
                    Price = int.Parse(txtPrice.Text),
                };

                dsProducts.InsertParameters["Title"].DefaultValue = newProduct.Title;
                dsProducts.InsertParameters["Description"].DefaultValue = newProduct.Description;
                dsProducts.InsertParameters["Count"].DefaultValue = newProduct.Count.ToString();
                dsProducts.InsertParameters["Price"].DefaultValue = newProduct.Price.ToString();

                try
                {
                    dsProducts.Insert();

                    cleanAddEditForm();
                }
                catch
                {
                }
            }
            else
            {
                return;
            }
            
        }

        protected void btnEditProduct_Click(object sender, EventArgs e)
        {
            if (txtTitle.Text != "" && txtCount.Text != "" && txtPrice.Text != "")
            {
                ProductViewModel productToSave = new ProductViewModel()
                {
                    Title = txtTitle.Text,
                    Description = txtDescription.Text,
                    Count = int.Parse(txtCount.Text),
                    Price = int.Parse(txtPrice.Text),
                };

                int editProductID = GetEditProductID();

                if (editProductID > 0)
                {
                    dsProducts.UpdateParameters["Title"].DefaultValue = productToSave.Title;
                    dsProducts.UpdateParameters["Description"].DefaultValue = productToSave.Description;
                    dsProducts.UpdateParameters["Count"].DefaultValue = productToSave.Count.ToString();
                    dsProducts.UpdateParameters["Price"].DefaultValue = productToSave.Price.ToString();
                    dsProducts.UpdateParameters["ID"].DefaultValue = editProductID.ToString();
                }

                try
                {
                    dsProducts.Update();
                    cleanAddEditForm();
                    enableAddMode();
                }
                catch
                {
                }
            }
            else
            {
                return;
            }
        }
    }
}