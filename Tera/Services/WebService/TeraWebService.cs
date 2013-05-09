using Data;
using System.ServiceModel;

namespace Tera.Services.WebService
{
    [ServiceContract(Name = "TeraWebService")]
    public class TeraWebService : IWebService
    {
        [OperationContract]
        public int TotalAccounts()
        {
            return Cache.LoadTotalAccounts();
        }

        [OperationContract]
        public int TotalOnlines()
        {
            return Cache.LoadTotalOnlines();
        }

        // Todo implement = add item via webservice to player
    }
}
