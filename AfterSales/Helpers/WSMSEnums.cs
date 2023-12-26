using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WSMS.Helpers
{
    public class WSMSEnums
    {
        public enum enumServiceStatus
        {
            New = 1,
            Queue = 2,
            Service = 3,
            Allergies = 4,
            TestResults = 5,
            Procedures = 6,
            Immunizations = 7,
            Insurance = 8
        }

        public enum enumServiceProblemStatus
        {
            New = 1,
            Done = 2,
            Invalid = 3,
            Failed = 4,
            QCPassed =5,
            QCFailed =6
        }

        public enum enumRequisitionStatus
        {
            Goal = 1,
            Result = 2,
            CollectionDate = 3,
            Note = 4,
            BloodPressure = 5,
            Distance = 6,
            
        }
        public enum enumRequisitionItemStatus
        {
            New = 1,
            Loan = 2,
            Sanctioned = 3,
            Requisiton = 4,
           
        }
    }
}