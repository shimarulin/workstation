from copier_templates_extensions import ContextHook

from tools.utils.mirror import mirror_dict


class ContextUpdater(ContextHook):
    update = False

    def hook(self, context):
        context["mirror_name_list"] = list(
            map(
                lambda code: mirror_dict[code]["country_name"],
                context["mirror_code_list"],
            )
        )
