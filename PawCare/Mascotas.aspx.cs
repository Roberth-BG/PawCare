using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PawCare
{
    public partial class Mascotas : Page
    {
        private readonly string cadenaConexion = ConfigurationManager.ConnectionStrings["CadenaPawCare"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListarMascotas();
            }
        }

        private void ListarMascotas()
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection(cadenaConexion))
                {
                    using (SqlCommand cmd = new SqlCommand("spListarMascotas", conexion))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);

                            gvMascotas.DataSource = dt;
                            gvMascotas.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar la lista: " + ex.Message, "danger");
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    using (SqlConnection conexion = new SqlConnection(cadenaConexion))
                    {
                        using (SqlCommand cmd = new SqlCommand("spInsertarMascota", conexion))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;

                            cmd.Parameters.Add(new SqlParameter("@NombreMascota", SqlDbType.VarChar, 100) { Value = txtNombreMascota.Text.Trim() });
                            cmd.Parameters.Add(new SqlParameter("@NombreDueno", SqlDbType.VarChar, 100) { Value = txtNombreDueno.Text.Trim() });
                            cmd.Parameters.Add(new SqlParameter("@Tipo", SqlDbType.VarChar, 20) { Value = ddlTipo.SelectedValue });
                            cmd.Parameters.Add(new SqlParameter("@Edad", SqlDbType.Int) { Value = Convert.ToInt32(txtEdad.Text.Trim()) });
                            cmd.Parameters.Add(new SqlParameter("@Telefono", SqlDbType.VarChar, 15) { Value = txtTelefono.Text.Trim() });

                            string obs = txtObservaciones.Text.Trim();
                            cmd.Parameters.Add(new SqlParameter("@Observaciones", SqlDbType.VarChar, 500) { Value = string.IsNullOrEmpty(obs) ? (object)DBNull.Value : obs });

                            conexion.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    LimpiarFormulario();
                    ListarMascotas();
                    MostrarMensaje("¡Mascota registrada exitosamente!", "success");
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Ocurrió un error al registrar: " + ex.Message, "danger");
                }
            }
        }

        private void LimpiarFormulario()
        {
            txtNombreMascota.Text = string.Empty;
            txtNombreDueno.Text = string.Empty;
            ddlTipo.SelectedIndex = 0;
            txtEdad.Text = string.Empty;
            txtTelefono.Text = string.Empty;
            txtObservaciones.Text = string.Empty;
        }

        private void MostrarMensaje(string texto, string tipoBootstrap)
        {
            lblMensaje.Text = $"<div class='alert alert-{tipoBootstrap} alert-dismissible fade show' role='alert'>" +
                             $"{texto}" +
                             $"<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>" +
                             $"</div>";
        }
    }
}