<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Mascotas.aspx.cs" Inherits="PawCare.Mascotas" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>PawCare - Registro de Mascotas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
            <div class="container">
                <a class="navbar-brand fw-bold" href="#">🐾 Veterinaria PawCare</a>
            </div>
        </nav>

        <div class="container mb-5">
            <asp:Label ID="lblMensaje" runat="server" EnableViewState="false"></asp:Label>

            <div class="row g-4">
                
                <div class="col-12 col-lg-5">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-white border-bottom py-3">
                            <h5 class="card-title fw-bold text-primary mb-0">Registrar Nueva Mascota</h5>
                        </div>
                        <div class="card-body">
                            
                            
                            <div class="mb-3">
                                <label for="txtNombreMascota" class="form-label">Nombre de la Mascota *</label>
                                <asp:TextBox ID="txtNombreMascota" runat="server" CssClass="form-control" placeholder="Escriba el nombre de la mascota"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNombreMascota" runat="server" 
                                    ControlToValidate="txtNombreMascota" ErrorMessage="El nombre de la mascota es obligatorio." 
                                    CssClass="text-danger small d-block mt-1" Display="Dynamic" />
                            </div>

                            
                            <div class="mb-3">
                                <label for="txtNombreDueno" class="form-label">Nombre del Dueño *</label>
                                <asp:TextBox ID="txtNombreDueno" runat="server" CssClass="form-control" placeholder="Escriba el nombre del dueño"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNombreDueno" runat="server" 
                                    ControlToValidate="txtNombreDueno" ErrorMessage="El nombre del dueño es obligatorio." 
                                    CssClass="text-danger small d-block mt-1" Display="Dynamic" />
                            </div>

                            
                            <div class="mb-3">
                                <label for="ddlTipo" class="form-label">Tipo de Mascota</label>
                                <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Perro" Value="Perro"></asp:ListItem>
                                    <asp:ListItem Text="Gato" Value="Gato"></asp:ListItem>
                                    <asp:ListItem Text="Otro" Value="Otro"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            
                            <div class="mb-3">
                                <label for="txtEdad" class="form-label">Edad (años) *</label>
                                <asp:TextBox ID="txtEdad" runat="server" CssClass="form-control" TextMode="Number" placeholder="Escriba la edad de la mascota"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEdad" runat="server" 
                                    ControlToValidate="txtEdad" ErrorMessage="La edad es obligatoria." 
                                    CssClass="text-danger small d-block mt-1" Display="Dynamic" />
                                <asp:RangeValidator ID="rvEdad" runat="server" 
                                    ControlToValidate="txtEdad" MinimumValue="0" MaximumValue="30" Type="Integer" 
                                    ErrorMessage="La edad debe estar entre 0 y 30 años." 
                                    CssClass="text-danger small d-block mt-1" Display="Dynamic" />
                            </div>

                            
                            <div class="mb-3">
                                <label for="txtTelefono" class="form-label">Teléfono (9 dígitos) *</label>
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Escriba el número de teléfono" MaxLength="9"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" 
                                    ControlToValidate="txtTelefono" ErrorMessage="El teléfono es obligatorio." 
                                    CssClass="text-danger small d-block mt-1" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revTelefono" runat="server" 
                                    ControlToValidate="txtTelefono" ValidationExpression="^[0-9]{9}$" 
                                    ErrorMessage="El teléfono debe tener exactamente 9 dígitos numéricos." 
                                    CssClass="text-danger small d-block mt-1" Display="Dynamic" />
                            </div>

                            
                            <div class="mb-3">
                                <label for="txtObservaciones" class="form-label">Observaciones (Opcional)</label>
                                <asp:TextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="Notas médicas, alergias, etc."></asp:TextBox>
                            </div>

                            <div class="d-grid">
                                <asp:Button ID="btnGuardar" runat="server" Text="Registrar Mascota" CssClass="btn btn-primary btn-lg" OnClick="btnGuardar_Click" />
                            </div>

                        </div>
                    </div>
                </div>

                
                <div class="col-12 col-lg-7">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-white border-bottom py-3">
                            <h5 class="card-title fw-bold text-secondary mb-0">Mascotas Registradas</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <asp:GridView ID="gvMascotas" runat="server" AutoGenerateColumns="False" 
                                    CssClass="table table-striped table-hover align-middle mb-0" 
                                    EmptyDataText="No hay pacientes registrados actualmente.">
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="ID" />
                                        <asp:BoundField DataField="NombreMascota" HeaderText="Mascota" />
                                        <asp:BoundField DataField="NombreDueno" HeaderText="Dueño" />
                                        <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
                                        <asp:BoundField DataField="Edad" HeaderText="Edad" />
                                        <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                                        <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>