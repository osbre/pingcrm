describe("Test Login", function() {
  beforeEach(function() {
    // before each test, we can automatically preserve the
    // 'session_id' and 'remember_token' cookies. this means they
    // will not be cleared before the NEXT test starts.
    //
    // the name of your cookies will likely be different
    // this is just a simple example
    Cypress.Cookies.debug(true);
    Cypress.Cookies.preserveOnce("_health_key");
  });

  it("Visits the main page", function() {
    cy.visit("http://localhost:5000/login");
  });

  it("Has title", function() {
    cy.contains("Welcome Back!");
    // cy.get("input#user_email").type("test@test.com");
    // cy.get("input#user_name").type("Testy McTestface");
    // cy.get("input#user_password").type("securepassword");
    // cy.get("input#user_confirm_password").type("securepassword");
    // cy.get("[type=submit]").click();
    // cy.contains("Welcome back Testy McTestface");
  });
});
