package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAsgAlb(t *testing.T) {
	t.Parallel()

	expectedName := fmt.Sprintf("vpc-terratest-%s", strings.ToLower(random.UniqueId()))
	asgName := fmt.Sprintf("asg-%s", strings.ToLower(random.UniqueId()))
	lcName := fmt.Sprintf("lc-%s", strings.ToLower(random.UniqueId()))
	albName := fmt.Sprintf("alb-%s", strings.ToLower(random.UniqueId()))

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/asg_alb",
		Upgrade:      true,

		Vars: map[string]interface{}{
			"vpc_name": expectedName,
			"asg_name": asgName,
			"lc_name":  lcName,
			"alb_name": albName,
		},
	}
	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

}
