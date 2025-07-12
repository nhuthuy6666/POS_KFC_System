using System;
using System.Collections.Generic;
using POS_KFC.Models;

namespace POS_KFC.Models.ViewModels
{
    public class EmployeeProfileViewModel
    {
        public EmployeeAccount Account { get; set; }
        public Employee Employee { get; set; }
        public List<WorkLog> WorkLogs { get; set; }
    }
}
