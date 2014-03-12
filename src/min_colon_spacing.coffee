module.exports = class MinColonSpacing

    rule :
        name : "min_colon_spacing"
        level : "ignore"
        message :"Colon assignment without proper spacing"
        spacing :
            left : 1
            right : 1
        description : """
            <p>This rule checks to see that there is a minimum spacing before
            and after the colon in a colon assignment (i.e., classes, objects).
            The rule is not as strict as the 'colon_assignment_rule' in the
            sense that only a minimum spacing is required and not the exact
            amount. This can be helpfull if you have files with object
            assignments where the colon are vertically aligned.

            The spacing amount is specified by
            spacing.left and spacing.right, respectively.
            A zero value means no spacing required.
            </p>
            <pre><code>
            #
            # If spacing.left and spacing.right is 1
            #

            # Good
            object = {spacing : true}
            class Good
              test : true

            class Router
              routes :
                "/main"            : "main"
                "/dashboard/users" : "dashboard
                "/settings"        : settings

            # Bad
            object = {spacing: true}
            class Bad
              test: false
            </code></pre>
            """

    tokens : [":"]

    lintToken : (token, tokenApi) ->
        spacingAllowances = tokenApi.config[@rule.name].spacing
        previousToken = tokenApi.peek -1
        nextToken = tokenApi.peek 1

        getSpaceFromToken = (direction) ->
            switch direction
                when "left"
                    token[2].first_column - previousToken[2].last_column - 1
                when "right"
                    nextToken[2].first_column - token[2].first_column - 1

        checkSpacing = (direction) ->
            spacing = getSpaceFromToken direction
            # when spacing is negative, the neighboring token is a newline
            if spacing < 0
                isSpaced = true
            else
                isSpaced = switch(direction)
                    when "left"
                        spacing >= parseInt spacingAllowances.left
                    when "right"
                        spacing <= parseInt spacingAllowances.right

            [isSpaced, spacing]

        [isLeftSpaced, leftSpacing] = checkSpacing "left"
        [isRightSpaced, rightSpacing] = checkSpacing "right"

        if isLeftSpaced and isRightSpaced
            null
        else
            context :
                """
                Incorrect spacing around column #{token[2].first_column}.
                Minimum Expected left: #{spacingAllowances.left}, right: -#{spacingAllowances.right}.
                Got left: #{leftSpacing}, right: #{rightSpacing}
                """