using System.Text.Json;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Young_Artist_Server.Models;
using Young_Artist_Server.ViewModels;

namespace Young_Artists_Server.Controllers
{
    [EnableCors("AllowAny")]
    [Route("api/[controller]")]
    [ApiController]
    public class CustomersController : ControllerBase
    {
        private readonly YoungArtistsContext _context;

        public CustomersController(YoungArtistsContext context)
        {
            _context = context;
        }

        // GET: api/Customers
        [HttpGet]
        public async Task<IEnumerable<Customers>> GetCustomers()
        {
            var data = from customer in _context.Customers
                       select customer;

            return data;
        }

        // GET: api/Customers/5
        [HttpGet("{id}")]
        public async Task<Customers> GetCustomers(int id)
        {
            var customers = await _context.Customers.FindAsync(id);

            return customers;
        }

        // PUT: api/Customers/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<string> PutCustomers(int id, Customers customers)
        {
            //if (id != customers.CustomerId)
            //{
            //    return "修改有誤";
            //}

            Customers? cus = await _context.Customers.FindAsync(id);
            cus.CustomerName=customers.CustomerName;
            cus.CustomerEmail=customers.CustomerEmail;
            cus.CustomerPassword=customers.CustomerPassword;
            cus.CustomerPhone=customers.CustomerPhone;
            cus.CustomerRegion=customers.CustomerRegion;
            cus.CustomerAddress=customers.CustomerAddress;
            cus.CustomerUpdateTimestamp
                = DateTime.Now.ToString();

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CustomersExists(id))
                {
                    return "修改有誤";
                }
                else
                {
                    throw;
                }
            }

            return "修改成功";
        }

        // 登入用post
        [HttpPost]
        public async Task<string> PostCustomers(CCustomerLoginViewModel vm)
        {
            Customers user = (_context.Customers.FirstOrDefault
                (t => t.CustomerEmail.Equals(vm.customerEmail) && t.CustomerPassword.Equals(vm.customerPassword)));

            if (user != null && user.CustomerPassword.Equals(vm.customerPassword))
            {

                var result = new
                {
                    user.CustomerId,
                    user.CustomerName,
                    user.CustomerEmail,
                    user.CustomerPassword,
                    user.CustomerPhone,
                    user.CustomerRegion,
                    user.CustomerAddress,
                    user.CustomerBirthDate,
                    user.CustomerGender,
                    user.CustomerCreatTimestamp,
                    user.CustomerUpdateTimestamp,
                    // 之後應該會用到
                    UserName = vm.customerEmail
                };

                string json = JsonSerializer.Serialize(result);

                return json;

            }
            return "帳號或密碼錯誤";
        }

        // 註冊用post
        [HttpPost("SignUp")]
        public async Task<string> PostCustomers(CCustomerSignUpViewModel vm)
        {


            if (_context.Customers.Any(c => c.CustomerEmail == vm.customerEmail || c.CustomerPhone == vm.customerPhone))
            {
                return "帳號已存在";
            }
            else
            {
                Customers cus = new Customers
                {
                    CustomerName = vm.customerName,
                    CustomerEmail = vm.customerEmail,
                    CustomerPassword = vm.customerPassword,
                    CustomerPhone = vm.customerPhone,
                    CustomerRegion = vm.customerRegion,
                    CustomerAddress = vm.customerAddress,
                    CustomerBirthDate = vm.customerBirthDate,
                    CustomerGender = vm.customerGender,
                    CustomerCreatTimestamp = DateTime.Now.ToString(),
                    CustomerUpdateTimestamp = DateTime.Now.ToString(),

                };
                _context.Customers.Add(cus);
                await _context.SaveChangesAsync();

                return "註冊成功";
            }           

            
        }

            // DELETE: api/Customers/5
            [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCustomers(int id)
        {
            var customers = await _context.Customers.FindAsync(id);
            if (customers == null)
            {
                return NotFound();
            }

            _context.Customers.Remove(customers);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CustomersExists(int id)
        {
            return _context.Customers.Any(e => e.CustomerId == id);
        }
    }
}
