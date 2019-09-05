# Shared modules for Red Hat Middleware docs

This repo contains modules that can be shared across Red Hat Middleware product docs.

## Sharing modules

You can share either a single module, or a set of modules that can (or should) be reused together - such as in an assembly. To share a single module or a set of modules:

1. [Prepare the module (or modules) for reuse](#preparing-a-module-for-reuse).
2. [Create a PR for the module (or modules)](#creating-a-pr-to-add-shared-modules).

### Preparing a module for reuse

Before you can share a module, you must prepare it for reuse. This ensures that anyone can quickly see who is using the module, and where they are using it. That way, if the module ever needs to be updated, you can notify the writers whose publications will be affected by the change.

* In the module, add a comment at the top indicating your GitHub user name and the book in which the module is used. For example:

   ```
   // Module included in the following:
   //
   // @bhardesty - Deploying AMQ Interconnect on OpenShift
  ```

### Creating a PR to add shared modules

After preparing the module (or modules) for reuse, you must create a PR to add it to the `mw-shared-modules/modules/` directory in this repository.

1. If you are sharing a set of modules (as opposed to a single module):

    a. In the `mw-shared-modules/modules/` directory, add a new directory for your set of modules. For an example, see `mw-shared-modules/modules/prometheus/`.

    b. Add your modules to the directory that you created.

    c. Add a `README.md` file and describe how the set of modules should be used.

      * List any attributes that the modules use.
      * Describe how the modules should be included. At a minimum, define the order in which the modules should be included.

2. Create a PR to add the module.

3. Wait. The PR will be reviewed and, once approved, merged.

3. After the PR is merged:

   * Update your book to point to the module. For more information, see [Reusing a shared module](#reusing-a-shared-module).
   * If necessary, notify other Middleware writers about the shared module so that others can use it.

TODO: describe how to share a module that includes images

## Updating a shared module

Making a change to a shared module impacts every book in which the module is used. Therefore, communication is important.

1. Create a PR with your updates.

2. In the PR, tag each writer who is listed in the comments in the beginning of the module.

3. Wait. Make sure that all affected writers have an opportunity to review your changes and determine how to implement the updated module in their books.

## Reusing a shared module

1. In the assembly in which the module should be used, include the module using the URL of the module's location. For example, to point to the _What operators are_ module:

   ```
   include::https://raw.githubusercontent.com/redhat-documentation/mw-shared-modules/master/modules/what-operators-are.adoc[leveloffset=+1]
   ```

2. If the shared module uses any attributes, define them in the assembly in which you included the module.

   For example, say the shared module uses an attribute called `:ProdName:` to represent the product name, but your book already uses a different attribute (say, `:ProductName:`) for the same thing. To use the shared module, you would add `:ProdName:` and set it to the value of `:ProductName:`:

   ```
   :ProdName: {ProductName}
   include::https://raw.githubusercontent.com/redhat-documentation/mw-shared-modules/master/modules/what-operators-are.adoc[leveloffset=+1]
   ```   
