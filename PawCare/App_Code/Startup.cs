using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(PawCare.Startup))]
namespace PawCare
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
